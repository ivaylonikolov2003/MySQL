DROP DATABASE IF EXISTS UserCommDB;
CREATE DATABASE UserCommDB;
USE UserCommDB;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(255) UNIQUE
);

CREATE TABLE block_list (
    block_id INT AUTO_INCREMENT PRIMARY KEY,
    blocker_id INT NOT NULL,
    blocked_id INT NOT NULL,
    block_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    unblock_date DATETIME,
    reason TEXT,
    FOREIGN KEY (blocker_id) REFERENCES users(user_id),
    FOREIGN KEY (blocked_id) REFERENCES users(user_id),
    UNIQUE (blocker_id, blocked_id)
);

CREATE TABLE friends (
    user_id1 INT NOT NULL,
    user_id2 INT NOT NULL,
    status ENUM('Pending', 'Accepted') NOT NULL,
    friend_since DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_interaction DATETIME,
    notes TEXT,
    PRIMARY KEY (user_id1, user_id2),
    FOREIGN KEY (user_id1) REFERENCES users(user_id),
    FOREIGN KEY (user_id2) REFERENCES users(user_id)
);

CREATE TABLE friend_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    requestor_id INT NOT NULL,
    requestee_id INT NOT NULL,
    message TEXT,
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Accepted', 'Declined', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (requestor_id) REFERENCES users(user_id),
    FOREIGN KEY (requestee_id) REFERENCES users(user_id)
);

CREATE TABLE message_types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_text TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    is_deleted BOOLEAN DEFAULT FALSE,
    attachment_url VARCHAR(255),
    priority ENUM('Low', 'Normal', 'High') DEFAULT 'Normal',
    type_id INT,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id),
    FOREIGN KEY (type_id) REFERENCES message_types(type_id)
);

CREATE TABLE profile_views (
    viewer_id INT NOT NULL,
    viewed_user_id INT NOT NULL,
    view_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    action_type ENUM('View', 'Like', 'Comment') DEFAULT 'View',
    FOREIGN KEY (viewer_id) REFERENCES users(user_id),
    FOREIGN KEY (viewed_user_id) REFERENCES users(user_id)
);

CREATE TABLE group_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE group_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL,
    permissions TEXT
);

CREATE TABLE groups_of_users (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(255) NOT NULL,
    description TEXT,
    is_private BOOLEAN DEFAULT TRUE,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    category_id INT,
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES group_categories(category_id)
);

CREATE TABLE group_members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    role_id INT,
    joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_activity DATETIME,
    FOREIGN KEY (group_id) REFERENCES groups_of_users(group_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES group_roles(role_id)
);

CREATE TABLE group_messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT NOT NULL,
    sender_id INT NOT NULL,
    message_text TEXT,
    attachment_url VARCHAR(255),
    is_pinned BOOLEAN DEFAULT FALSE,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES groups_of_users(group_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE
);



