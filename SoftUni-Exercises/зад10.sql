delimiter $$
create procedure usp_get_employees_from_town(town_name varchar(50))
begin
	select first_name, last_name
    from towns
    join addresses on towns.town_id = addresses.town_id
    join employees on addresses.address_id = employees.address_id
    where towns.name = town_name
    order by first_name, last_name, employee_id;
end $$
delimiter ;

CALL usp_get_employees_from_town('Sofia');