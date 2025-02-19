delimiter $$
create procedure usp_transfer_money(from_account_id int, to_account_id int, amount decimal(19, 4))
begin
	if amount > 0 
		and from_account_id <> to_account_id
		and (select accounts.id from accounts where accounts.id = to_account_id) is not null
		and (select accounts.id from accounts where accounts.id = from_account_id) is not null
		and (select accounts.balance from accounts where accounts.id = from_account_id) >= amount
    then
		start transaction;
        
        update accounts
        set accounts.balance = accounts.balance + amount
        where accounts.id = to_account_id;
        
        update accounts
        set accounts.balance = accounts.balance - amount
        where accounts.id = from_account_id;
        
        if (select accounts.balance from accounts where accounts.id = from_account_id) < 0
			then rollback;
		else
			commit;
		end if;
	end if;
end $$
delimiter ;

CALL usp_transfer_money(1, 2, 10);
CALL usp_transfer_money(2, 1, 10);

SELECT a.id AS 'account_id', a.account_holder_id, a.balance
FROM `accounts` AS a
WHERE a.id IN (1 , 2);