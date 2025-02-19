delimiter $$
create procedure usp_get_holders_with_balance_higher_than(in money decimal(19, 4))
begin
	select first_name, last_name
    from account_holders
    join accounts on account_holders.id = accounts.account_holder_id
    group by account_holders.id, account_holders.first_name, account_holders.last_name
    having sum(accounts.balance) > money
    order by account_holders.first_name, account_holders.last_name;
end $$
delimiter ;

CALL usp_get_holders_with_balance_higher_than(7000);