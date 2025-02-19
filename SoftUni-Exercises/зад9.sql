delimiter $$
create procedure usp_get_towns_starting_with(town_name varchar(10))
begin
	select name
    from towns
    where name like concat(town_name, '%')
    order by name;
end $$
delimiter ;

CALL usp_get_towns_starting_with('b');
CALL usp_get_towns_starting_with('be');
CALL usp_get_towns_starting_with('berlin');