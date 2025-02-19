delimiter $$
create procedure usp_add_numbers(first_number int, second_number int, out result int)
begin 
	set result = first_number + second_number;
end $$
delimiter ;

set @answer = 0;
call usp_add_numbers(5, 6, @answer);
select @answer;