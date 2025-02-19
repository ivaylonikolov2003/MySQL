delimiter $$
create procedure usp_deposit_money(account_id int, money_amount decimal(19, 4))
begin
	if money_amount > 0 then
    start transaction;
    
		update accounts
		set accounts.balance = accounts.balance + money_amount
		where accounts.id = account_id;
    
		if (select accounts.balance from accounts where accounts.id = account_id) < 0
			then rollback;
		else
			commit;
		end if;
    end if;
end $$
delimiter ;
CALL usp_deposit_money(1, 10);
select accounts.id, accounts.account_holder_id, accounts.balance
from accounts
where accounts.id = 1;