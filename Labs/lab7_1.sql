use school_sport_clubs;

delimiter $
drop database if exists testProc3 $
create procedure testProc3(inout testParam varchar(255))
begin
select testParam;
set testParam = "Georgi Georgiev";
select testParam;
end $
delimiter ;
set @test = "Ivan Ivanov";
call testProc3(@test);
select @test;