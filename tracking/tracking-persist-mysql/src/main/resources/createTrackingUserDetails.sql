create table if not exists TrackingUserDetails
(
	userid varchar(10) not null,
    username varchar(20) not null, 
	password varchar(70) not null, 
    email varchar(350) not null,
    enabled tinyint(1) not null,
    accountnonexpired tinyint(1) not null,
    nonlocked tinyint(1) not null,
    credentialsnonexpired tinyint(1) not null,
    constraint pk_trackinguserdetails primary key(userid)
);

-- table: this table holds the informations about the users of the ilona system

-- userid: primary key, an arbitrary text, 
-- but prefered sample: user + number example: user1. user2


-- username: arbitrary username
-- pattern: a-z,A-Z,0-9, starts with a letter example: a9999zzzz222sAAAR, but not 1aaZZwwwww

-- password: hashed password + auto bcrypt salt, 60 characters

-- email: a valid email address General Email Regex (RFC 5322 Official Standard)
-- length: 64 local + 255 domain length RFC standard
-- ^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$

-- enabled: the current account is enabled or disabled by the admin

-- accountnonexpired: the current account is expired

-- nonlocked: after many failed authentication, the account will be blocked for 10 minutes(?)

-- credentialsnonexpired: the user password is expired and no longer valid, the password must be changed