USE usercommdb;

INSERT INTO users (username, password_hash, first_name, last_name, address, phone, email)
VALUES
('user1', 'hash1', 'John', 'Doe', '123 Elm St', '1234567890', 'john.doe@example.com'),
('user2', 'hash2', 'Jane', 'Doe', '456 Oak St', '2345678901', 'jane.doe@example.com'),
('user3', 'hash3', 'Jim', 'Beam', '789 Pine St', '3456789012', 'jim.beam@example.com'),
('user4', 'hash4', 'Jill', 'Valley', '101 Apple St', '4567890123', 'jill.valley@example.com'),
('user5', 'hash5', 'Jack', 'Hill', '202 Cherry St', '5678901234', 'jack.hill@example.com');

INSERT INTO block_list (blocker_id, blocked_id, unblock_date, reason)
VALUES
(1, 2, NULL, 'Spamming messages'),
(2, 3, '2024-12-31 23:59:59', 'Inappropriate content sharing'),
(3, 4, '2024-06-30 23:59:59', 'Harassment'),
(4, 1, NULL, 'Repeated unauthorized activities');

INSERT INTO friends (user_id1, user_id2, status, last_interaction, notes)
VALUES
(1, 2, 'Accepted', '2024-04-10 14:30:00', 'Met at a conference.'),
(1, 3, 'Pending', NULL, 'Introduced by a mutual friend.'),
(2, 4, 'Accepted', '2024-04-12 09:20:00', 'Neighbors since childhood.'),
(3, 4, 'Accepted', '2024-04-15 16:45:00', 'Colleagues at work.');

INSERT INTO friend_requests (requestor_id, requestee_id, message, status)
VALUES
(1, 2, 'Hi! Lets connect.', 'Pending'),
(2, 3, 'Please add me to your network.', 'Accepted'),
(3, 4, 'I found your profile interesting.', 'Declined'),
(4, 1, 'Looking forward to connecting!', 'Pending');

INSERT INTO message_types (type_name, description)
VALUES
('Greeting', 'Standard greeting message'),
('Reminder', 'Reminder message'),
('Notification', 'General notification'),
('Alert', 'Urgent or important information');

INSERT INTO messages (sender_id, receiver_id, message_text, priority, type_id)
VALUES
(1, 2, 'Hello! How are you today?', 'Normal', 1),
(2, 3, 'Dont forget our meeting tomorrow.', 'High', 2),
(3, 4, 'You have a new alert in your account.', 'High', 4),
(4, 1, 'Check out the new event!', 'Normal', 3);

INSERT INTO profile_views (viewer_id, viewed_user_id, action_type)
VALUES
(1, 2, 'View'),
(2, 3, 'Like'),
(3, 4, 'Comment'),
(4, 1, 'Like');

INSERT INTO group_categories (category_name, description)
VALUES
('Technology', 'Discussion about new technology trends'),
('Sports', 'Sports teams and events discussion'),
('Art', 'Talks about different art forms'),
('Travel', 'Share travel experiences and tips');

INSERT INTO group_roles (role_name, permissions)
VALUES
('Admin', 'All permissions'),
('Moderator', 'Can moderate discussions'),
('Member', 'Can view and post messages'),
('Guest', 'Can only view messages');

INSERT INTO groups_of_users (group_name, description, is_private, created_by, category_id)
VALUES
('Tech Enthusiasts', 'A group for people who love tech', FALSE, 1, 1),
('Local Runners', 'Group for local runners to share experiences', TRUE, 2, 2),
('Photographers Hub', 'A group for professional photographers', FALSE, 3, 3),
('World Explorers', 'Share and learn about great travel destinations', TRUE, 4, 4);

INSERT INTO group_members (group_id, user_id, role_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 1);

INSERT INTO group_messages (group_id, sender_id, message_text)
VALUES
(1, 1, 'Welcome to Tech Enthusiasts!'),
(2, 2, 'Don’t forget about our run tomorrow morning!'),
(3, 3, 'Here are some tips for taking better photos.'),
(4, 4, 'Check out my latest travel blog post!');






