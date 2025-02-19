delimiter $$
create trigger before_insert_group
before insert on student_sport
for each row
begin
	declare group_count int;
    select count(*) into group_count
    from student_sport
    where student_id = new.student_id;
    
    if group_count >= 2 then
		signal sqlstate '45000'
        set message_text = 'Error: This student is already assiged to two groups.';
	end if;
end $$
delimiter ;
