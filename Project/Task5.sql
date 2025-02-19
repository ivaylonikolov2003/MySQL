SELECT 
    u.username,
    u.email,
    g.group_name,
    gm.joined_at,
    m.message_text
FROM users u
LEFT JOIN group_members gm ON u.user_id = gm.user_id
LEFT JOIN groups_of_users g ON gm.group_id = g.group_id
LEFT JOIN group_messages m ON u.user_id = m.sender_id
UNION
SELECT 
    u.username,
    u.email,
    g.group_name,
    gm.joined_at,
    m.message_text
FROM group_members gm
RIGHT JOIN users u ON u.user_id = gm.user_id
RIGHT JOIN groups_of_users g ON gm.group_id = g.group_id
RIGHT JOIN group_messages m ON u.user_id = m.sender_id;