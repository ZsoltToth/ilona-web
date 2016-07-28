create table if not exists TrackingDevices(
	deviceid varchar(50) not null,
    deviceowner varchar(10) not null,
    devicename varchar(100) default 'ILONA - TRACKING DEVICE NAME DEFAULT VALUE' not null,
    devicetypename varchar(100) default 'ILONA - TRACKING DEVICE TYPE NAME DEFAULT VALUE' null,
    devicetype varchar(10) default 'MOBILE' not null,
    constraint PK_TrackingDevices primary key(deviceid, deviceowner),
    constraint FK_TrackingDevices_OwnerRef foreign key(deviceowner) references TrackingUsers(userid) on delete cascade
    
);