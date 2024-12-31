//
//  MinewBeaconConnection.h
//  MinewBeaconAdminSDKDemo
//
//  Created by SACRELEE on 28/09/2016.
//  Copyright © 2016 minewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ConnectionState) {
    ConnectionStateConnecting = 1,
    ConnectionStateConnected,
    ConnectionStateConnectFailed,
    ConnectionStateDisconnected,
};

@class MinewBeaconSetting, MinewBeacon, MinewBeaconConnection;

@protocol MinewBeaconConnectionDelegate <NSObject>

@optional

- (void)beaconConnection:(MinewBeaconConnection *)connection didChangeState:(ConnectionState)state;

- (void)beaconConnection:(MinewBeaconConnection *)connection didWriteSetting:(BOOL)success;

@end

@interface MinewBeaconConnection : NSObject

// 代理
@property (nonatomic, weak) id<MinewBeaconConnectionDelegate> delegate;

// 当前状态
@property (nonatomic, assign) ConnectionState state;

// 仅当连接状态下才有值
@property (nonatomic, strong, readonly) MinewBeaconSetting *setting;

// 获取一个连接实例
- (MinewBeaconConnection *)initWithBeacon:(MinewBeacon *)beacon;

// 发起连接
- (void)connect;

// 断开连接
- (void)disconnect;

// 更新数据到设备并重启生效
- (BOOL)writeSetting:(NSString *)password;



@end
