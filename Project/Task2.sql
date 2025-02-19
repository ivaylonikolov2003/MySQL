SELECT
    u1.username AS blocker,
    u2.username AS blocked,
    b.block_date,
    b.unblock_date,
    b.reason
FROM block_list AS b
JOIN users AS u1 ON b.blocker_id = u1.user_id
JOIN users AS u2 ON b.blocked_id = u2.user_id
WHERE b.reason LIKE '%Spamming messages%' AND b.unblock_date IS NULL;
