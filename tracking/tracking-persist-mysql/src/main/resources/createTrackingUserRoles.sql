create table if not exists TrackingUserRoles(
	userid varchar(10) not null,
    userrole varchar(20) not null,
    constraint PK_TrackingUserRoles primary key(userid, userrole),
    constraint FK_TrackingUserRolesUserid foreign key(userid) references TrackingUsers(userid)
    on delete cascade
);

-- table: This table stores the users' roles
-- this table is in a  (TrackingUserDetails) 1 : N (This) relationship

-- userid: the primary key from TrackingUserDetails

-- userrole: the current role of the user
-- ROLE_ADMIN / ROLE_USER