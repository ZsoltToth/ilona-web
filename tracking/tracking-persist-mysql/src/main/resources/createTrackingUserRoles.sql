create table if not exists TrackingUserRoles
(
	userid varchar(10) not null,
    userrole varchar(15) not null,
    constraint pk_trackinguserroles primary key(userid,userrole),
    
    constraint fk_userid_trackinguserroles foreign key(userid)
    references TrackingUserDetails(userid) on delete cascade

);

-- table: This table stores the users' roles
-- this table is in a  (TrackingUserDetails) 1 : N (This) relationship

-- userid: the primary key from TrackingUserDetails

-- userrole: the current role of the user
-- ROLE_ADMIN / ROLE_USER