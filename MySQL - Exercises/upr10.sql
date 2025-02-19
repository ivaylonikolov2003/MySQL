delete from salarypayments;
insert into salarypayments (coach_id, month, year, salaryAmount, dateOfPayment)
select old_coach_id, old_month, old_year, old_salaryAmount, old_dateOfPayment
from salarypayments_log
where operation = 'DELETE';

select * from salarypayments;