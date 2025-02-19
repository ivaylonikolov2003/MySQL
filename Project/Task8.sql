USE usercommdb;

DELIMITER //

CREATE TRIGGER PreventBlockedMessages
BEFORE INSERT ON messages
FOR EACH ROW
BEGIN
  DECLARE is_blocked INT;

  SELECT COUNT(*) INTO is_blocked
  FROM block_list
  WHERE blocker_id = NEW.receiver_id
    AND blocked_id = NEW.sender_id
    AND (unblock_date IS NULL OR unblock_date > CURRENT_TIMESTAMP);
    
  IF is_blocked > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot send message, sender is blocked by the receiver.';
  END IF;
END //

DELIMITER ;
/*Първи случай, когато съобщението е блокирано*/
INSERT INTO users (username, password_hash, first_name, last_name, email) VALUES
('sender', 'hash123', 'Sender', 'User', 'sender@example.com'),
('receiver', 'hash456', 'Receiver', 'User', 'receiver@example.com');

INSERT INTO block_list (blocker_id, blocked_id, unblock_date, reason) VALUES
((SELECT user_id FROM users WHERE username='receiver'), (SELECT user_id FROM users WHERE username='sender'), NULL, 'test block');

INSERT INTO messages (sender_id, receiver_id, message_text, priority, type_id) VALUES
((SELECT user_id FROM users WHERE username='sender'), (SELECT user_id FROM users WHERE username='receiver'), 'Test message', 'Normal', 1);

SELECT * FROM messages WHERE sender_id = (SELECT user_id FROM users WHERE username='sender')
AND receiver_id = (SELECT user_id FROM users WHERE username='receiver');

/*Втори случай, когато съобщението не е блокирано*/
INSERT INTO users (username, password_hash, first_name, last_name, email) VALUES
('newSender', 'hash789', 'NewSender', 'User', 'newSender@example.com'),
('newReceiver', 'hash890', 'NewReceiver', 'User', 'newReceiver@example.com');

INSERT INTO messages (sender_id, receiver_id, message_text, priority, type_id) VALUES
((SELECT user_id FROM users WHERE username='newSender'), (SELECT user_id FROM users WHERE username='newReceiver'), 'Hello there!', 'Normal', 1);

SELECT * FROM messages WHERE sender_id = (SELECT user_id FROM users WHERE username='newSender')
AND receiver_id = (SELECT user_id FROM users WHERE username='newReceiver');

