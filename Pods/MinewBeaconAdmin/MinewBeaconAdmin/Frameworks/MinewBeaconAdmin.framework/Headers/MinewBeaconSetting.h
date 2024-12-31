//
//  MinewBeaconSetter.h
//  MinewBeaconAdminSDKDemo
//
//  Created by SACRELEE on 28/09/2016.
//  Copyright © 2016 minewTech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MinewBeaconSetting : NSObject

// uuid
@property (nonatomic, copy ) NSString *uuid;

// major
@property (nonatomic, assign ) NSInteger major;

// minor
@property (nonatomic, assign ) NSInteger minor;

// the beacon's name
@property (nonatomic, copy ) NSString *name;

// the working mode.
@property (nonatomic, assign ) NSInteger mode;

// broadcast period of this beacon.
@property (nonatomic, assign ) NSInteger broadcastInterval;

// wechat device id or the device sn.
@property (nonatomic, assign ) NSInteger deviceId;

// the reboot password.
@property (nonatomic, copy ) NSString *password;

// txpower @ 1 meter.
@property (nonatomic, assign ) NSInteger calibratedTxPower;

// txpower
@property (nonatomic, assign ) NSInteger txPower;

// mac address of this beacon, some times it may nil.
@property (nonatomic, strong, readonly ) NSString *mac;

// current battery.
@property (nonatomic, assign, readonly ) NSInteger battery;

// when it's YES, the manager has connected to this beacon.
@property (nonatomic, assign, readonly ) BOOL connected;


// oem information
// manufacture.
@property (nonatomic, strong, readonly ) NSString *manufacture;

// manufacture SN.
@property (nonatomic, strong, readonly ) NSString *SN;

// model string.
@property (nonatomic, assign, readonly ) NSString *model;

// version of hardware
@property (nonatomic, strong, readonly ) NSString *hardware;

// version of software.
@property (nonatomic, strong, readonly ) NSString *software;

// version of firmware.
@property (nonatomic, strong, readonly ) NSString *firmware;

// system label.
@property (nonatomic, strong, readonly ) NSString *systemId;

// IEEE regulatory certification data.
@property (nonatomic, strong, readonly ) NSString *certData;

// 导入Json字串
- (void)importJSON:(NSString *)jsonString;

// 导出Json字串
- (NSString *)exportJSON;



@end
