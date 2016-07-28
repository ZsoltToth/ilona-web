create table if not exists trackingUserDevices(
	ownerid varchar(10) not null,
    deviceid varchar(50) not null,
    constraint PK_trackingUserDevices primary key(ownerid,deviceid),
    constraint FK_trackingUserDevicesUserRef foreign key (ownerid) references TrackingUsers(userid) on delete cascade,
    constraint FK_trackingUserDevicesDeviceRef foreign key (deviceid) references TrackingDevices(deviceid) on delete cascade
);