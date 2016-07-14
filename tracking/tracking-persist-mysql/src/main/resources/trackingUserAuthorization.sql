--Tracking user multy value table for the roles
-- username: arbitrary username, maximum 20 characters
-- ROLE format: ROLE_ROLENAME (everything is uppercase)
create table if not exists TrackingUserRoles(
	userid varchar(20),
	role varchar(10),
	primary key (userid,role),
	foreign key (userid) references TrackingUsers(userid)
    on delete cascade
);

CREATE TABLE if not exists user_roles (
  user_role_id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (user_role_id),
  UNIQUE KEY uni_username_role (role,username),
  KEY fk_username_idx (username),
  CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES users (username)
  );