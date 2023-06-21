package com.example.mils.demo.web.milestone;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.mils.demo.domain.milestone.MilestoneEntity;
import com.example.mils.demo.domain.milestone.MilestoneService;

import lombok.AllArgsConstructor;


@Controller
@AllArgsConstructor
@RequestMapping("/milestones")
public class MilestoneController {

    private final MilestoneService milestoneService;

    @GetMapping()
    public String showList(Model model) {
        List<MilestoneEntity> milestoneList = milestoneService.findAll();

        model.addAttribute("milestoneList", milestoneList);

        return "milestones/list";
    }

    @GetMapping("/{id}")
    public String showDetail(@PathVariable("id") long id, Model model) {
        MilestoneEntity milestone = milestoneService.findById(id);
        model.addAttribute("milestone", milestone);

        return "milestones/detail";
    }

    @GetMapping("/creationForm")
    public String showCreationForm(@ModelAttribute("creationForm") MilestoneForm form) {
        return "milestones/creationForm";
    }

    @PostMapping("/creationForm")
    public String create(@ModelAttribute("creationForm") @Validated MilestoneForm milestoneForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "milestones/creationForm";
        }
        milestoneService.create(milestoneForm.getTitle(), milestoneForm.getDescription());
        return "redirect:/milestones";
    }
}
