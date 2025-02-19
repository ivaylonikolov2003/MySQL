delete from customers where id = 1;

begin;
update customer_accounts
set amount = amount - 50000
where id = 3 and amount >= 50000;

update customer_accounts
set amount = amount + 50000
where id = 1;
commit;