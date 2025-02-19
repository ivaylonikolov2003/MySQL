delimiter $$
create procedure usp_get_holders_full_name()
begin
	select concat(first_name, ' ', last_name) as full_name
    from account_holders
    order by full_name, account_holders.id;
end $$
delimiter ;

call usp_get_holders_full_name();