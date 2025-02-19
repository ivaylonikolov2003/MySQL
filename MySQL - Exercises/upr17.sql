delimiter $$
create trigger update_unblock_date
before update on block_list
for each row
begin
	if new.unblock_date <= current_timestamp() then
		delete from block_list where block_id = new.block_id;
	end if;
end $$
delimiter ;

delimiter $$
create trigger update_last_interaction
after update on message
for each row
begin
	update friends
    set last_interaction = current_timestamp()
    where (user_id1 = new.sender_id and user_id2 = new.receiver_id)
    or (user_id1 = new.receiver_id and user_id2 = new.sender_id);
end $$
delimiter ;

delimiter $$
create trigger after_insert_group_members
after insert on group_members
for each row
begin
	declare isGroupPrivate boolean;
    
    select is_private into isGroupPrivate from group_of_users where group_id = new.group.id;
    
    if isGroupPrivate = false then
		update group_members
        set status = 'Approved'
        where member_id = new.member_id;
	end if;
end $$
delimiter ;