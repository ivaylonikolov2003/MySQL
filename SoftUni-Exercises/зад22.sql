create table logs(
log_id int not null primary key auto_increment,
account_id int not null,
old_sum decimal(19, 4) not null,
new_sum decimal(19, 4) not null
);

delimiter $$
create trigger log_accounts
after update on accounts
for each row
begin
	if old.balance <> new.balance then
    insert into logs(account_id, old_sum, new_sum)
    values(old.id, old.balance, new.balance);
    end if;
end $$
delimiter ;

CALL usp_transfer_money(1, 2, 10);
CALL usp_transfer_money(2, 1, 10);

SELECT * FROM `logs`;