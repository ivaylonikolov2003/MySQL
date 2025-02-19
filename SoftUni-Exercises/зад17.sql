delimiter $$
create function ufn_calculate_future_value(sum decimal(19, 4), yearly_interest_rate decimal(19, 4), number_of_years int)
returns decimal(19, 4) DETERMINISTIC READS SQL DATA
begin
	declare future_value decimal(19, 4);
    set future_value = sum * pow((1 + yearly_interest_rate), number_of_years);
    return future_value;
end $$
delimiter ;

SELECT ufn_calculate_future_value(1000, 0.1, 5);