create table users (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256),
    email VARCHAR(256),
    -- TODO: NOT NULL制約の付与
    password VARCHAR(256),
    -- TODO: NOT NULL制約の付与
    authorities VARCHAR(256) NOT NUll,
    profile_img VARCHAR(256),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp NUll default NUll
);

create table milestones (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    -- TODO: NOT NULL制約の付与
    name VARCHAR(256) NOT NULl,
    description VARCHAR(256) NOT NULl,
    progress INT NOT NUll default 0,
    deadline timestamp default current_timestamp,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

create table tasks (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    -- TODO: NOT NULL制約の付与
    milestone_id BIGINT,
    -- TODO: NOT NULL制約の付与
    name VARCHAR(256) NOT NUll,
    description VARCHAR(256) NOT NULl,
    is_complete BOOLEAN NOT NUll default false,
    deadline timestamp default current_timestamp,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (milestone_id) REFERENCES milestones(id) ON DELETE SET NULL
);

create table labels (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL UNIQUE,
    color VARCHAR(256) default 'grey',
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
);

create table task_labels (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    task_id BIGINT NOT NULL,
    label_id BIGINT NOT NULL,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    -- NOTE: taskが削除されたら、ラベルとの紐づきレコードは削除する
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
     -- NOTE: labelが削除されたら、タスクとの紐づきレコードは削除する
    FOREIGN KEY (label_id) REFERENCES labels(id) ON DELETE CASCADE
);