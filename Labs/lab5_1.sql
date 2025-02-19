use school_sport_clubs;
-- 1
select count(*) from sportGroups;

-- 2
select group_id as GroupID, sum(paymentAmount) as payment
from taxesPayments
group by group_id
having payment > 11000;

-- 3
create view sportPlace
as select s.name as Sport, sg.location as Place
from sports as s join sportGroups as sg
on s.id = sg.sport_id;

select * from sportPlace;

