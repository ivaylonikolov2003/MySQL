SELECT u.username, COUNT(f1.user_id1) AS friend_count
FROM users u
JOIN friends f1 ON u.user_id = f1.user_id1
JOIN friends f2 ON u.user_id = f2.user_id2 AND f2.status = 'Accepted'
LEFT JOIN block_list bl1 ON u.user_id = bl1.blocker_id AND bl1.blocked_id = f1.user_id2 AND bl1.unblock_date IS NULL
LEFT JOIN block_list bl2 ON u.user_id = bl2.blocked_id AND bl2.blocker_id = f1.user_id2 AND bl2.unblock_date IS NULL
WHERE f1.status = 'Accepted'
AND (bl1.blocker_id IS NULL OR bl1.unblock_date < NOW())
AND (bl2.blocker_id IS NULL OR bl2.unblock_date < NOW())
GROUP BY u.user_id;
