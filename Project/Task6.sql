SELECT 
    u.first_name AS blocked_first_name,
    u.last_name AS blocked_last_name,
    b.reason AS block_reason,
    (
        SELECT CONCAT(first_name, ' ', last_name)
        FROM users
        WHERE user_id = b.blocker_id
    ) AS blocker_name,
    (
        SELECT reason
        FROM block_list
        WHERE blocker_id = b.blocker_id AND blocked_id = b.blocked_id
    ) AS block_reason
FROM block_list b
JOIN users u ON b.blocked_id = u.user_id;