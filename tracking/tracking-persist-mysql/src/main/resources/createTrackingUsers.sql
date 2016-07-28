create table if not exists TrackingUsers(

	userid varchar(10) not null,
    username varchar(40) not null,
    email varchar(350) not null,
    password varchar(80) not null,
    enabled tinyint(1) not null,
    nonexpired timestamp not null, -- ezt engedi?!
    loginattempts smallint not null,
    firstbadloginattempt timestamp default now() not null, -- nem engedi not nullal, csak így defaulttal
	credentialsnonexpired timestamp default now() not null, -- nem engedu not nullal, csak így defaulttal
    constraint PK_TrackingUsers primary key(userid)
);