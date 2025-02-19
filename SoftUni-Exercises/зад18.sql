delimiter $$
create procedure usp_calculate_future_value_for_account(account_id int, interest_rate decimal(19, 4))
begin
	select accounts.id, account_holders.first_name, account_holders.last_name, accounts.balance, 
    ufn_calculate_future_value(accounts.balance, interest_rate, 5) as balance_in_5_years
    from account_holders
    join accounts on account_holders.id = accounts.account_holder_id
    where accounts.id = account_id;
end $$
delimiter ;

CALL usp_calculate_future_value_for_account(1, 0.1);