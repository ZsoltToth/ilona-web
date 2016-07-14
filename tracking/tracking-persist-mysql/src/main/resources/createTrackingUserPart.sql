create table if not exists TrackingUsers (
	userid varchar(20), -- arbitrary username
	password varchar(80) not null, -- hashed password
	enabled TINYINT(1) not null default 1, -- is this account enabled
	joinDate timestamp not  null,-- join date
	CONSTRAINT PK_USERS PRIMARY KEY(userid)	
);