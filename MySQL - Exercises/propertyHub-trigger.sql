delimiter $
create trigger checkPreviousDeals
after insert on ads
for each row
begin
	declare deals_count int;
    declare discount_rate decimal(10, 2);
    declare property_customer_id int;
    
    SELECT customerId INTO property_customer_id
    FROM properties
    WHERE id = NEW.propertyId;
    
    select count(*) into deals_count
    from deals
    join ads on ads.dealId = deals.id
    where ads.propertyId = NEW.propertyId and deals.paymentType = 'sale';
    
    if deals_count between 1 and 5 then
		set discount_rate = 0.5;
	elseif deals_count > 5 then
		set discount_rate = 1.0;
	else
		set discount_rate = 0;
	end if;
    
    if discount_rate > 0 then
		call SendEMailToCustomer(property_customer_id, NEW.propertyId, discount_rate);
	end if;
end $
delimiter ;