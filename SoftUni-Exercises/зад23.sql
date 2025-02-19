create table notification_emails(
id int not null primary key auto_increment,
recipient int not null,
subject varchar(50) not null,
body varchar(255) not null
);

delimiter $$
create trigger tr_notification_emails
after insert on logs
for each row
begin 
	insert into notification_emails(recipient, subject, body)
    values(new.account_id, concat('Balance change for account: ', new.account_id),
    concat('On ', date_format(now(), '%b %d %Y at %r'), 'your balance was change from ', round(new.old_sum, 2), 'to ', round(new.new_sum, 2), '.'));
end $$
delimiter ;

SELECT * FROM `notification_emails`;