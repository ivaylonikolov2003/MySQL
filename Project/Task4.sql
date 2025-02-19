SELECT 
	u.username,
    g.group_name,
    gm.joined_at,
    m.message_text,
    m.timestamp AS message_sent
FROM users u
INNER JOIN group_members gm ON u.user_id = gm.user_id
INNER JOIN groups_of_users g ON gm.group_id = g.group_id
INNER JOIN group_messages m ON u.user_id = m.sender_id AND gm.group_id = m.group_id
ORDER BY u.username, g.group_name, m.timestamp DESC;
