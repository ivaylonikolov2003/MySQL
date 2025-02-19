use usercommdb;
SELECT 
    u.username,
    mt.type_name,
    g.group_name,
    m.priority,
    COUNT(*) AS total_messages
FROM messages m
JOIN users u ON m.sender_id = u.user_id
JOIN message_types mt ON m.type_id = mt.type_id
JOIN group_messages gm ON gm.message_id = m.message_id
JOIN groups_of_users g ON gm.group_id = g.group_id
GROUP BY u.username, mt.type_name, g.group_name, m.priority
ORDER BY u.username, mt.type_name, g.group_name, m.priority;
