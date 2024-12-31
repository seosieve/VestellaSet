//
//  MinewBeacon.h
//  BeaconCFG
//
//  Created by SACRELEE on 18/09/2016.
//  Copyright © 2016 YLWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinewBeacon : NSObject

// uuid
@property (nonatomic, copy, readonly ) NSString *uuid;

// major
@property (nonatomic, assign, readonly ) NSInteger major;

// minor
@property (nonatomic, assign, readonly ) NSInteger minor;

// name
@property (nonatomic, copy, readonly ) NSString *name;

// deviceId
@property (nonatomic, assign, readonly ) NSInteger deviceId;

// mac
@property (nonatomic, copy, readonly) NSString *mac;

// txpower
@property (nonatomic, assign, readonly ) NSInteger txPower;

// rssi
@property (nonatomic, assign, readonly ) NSInteger rssi;

// 距离
@property (nonatomic, assign, readonly ) float distance;

// 电池
@property (nonatomic, assign, readonly ) NSInteger battery;

// 是否在扫描范围内
@property (nonatomic, assign, readonly ) BOOL inRange;

// 是否可连接
@property (nonatomic, assign, readonly ) BOOL connectable;

// 导出json字串
- (NSString *)exportJSON;

// 导入json字串
- (void)importJSON:(NSString *)jsonString;


@end
