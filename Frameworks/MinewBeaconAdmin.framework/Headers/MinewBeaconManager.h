//
//  MinewBeaconManager.h
//  BeaconCFG
//
//  Created by SACRELEE on 18/09/2016.
//  Copyright © 2016 YLWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinewBeacon.h"

// bluetooth state enum.
typedef NS_ENUM( NSInteger, BluetoothState) {
    
    BluetoothStateUnknown = 0,   // can't get the state of bluetooth
    BluetoothStatePowerOn,       // bluetooth power on
    BluetoothStatePowerOff,      // bluetooth power off
    
};


@class MinewBeaconManager;


@protocol MinewBeaconManagerDelegate <NSObject>

@optional

/**
 *  listen the state of bluetooth
 *
 *  @param manager a manager instance
 *  @param state   current bluetooth state
 */
- (void)minewBeaconManager:(MinewBeaconManager *)manager didUpdateState:(BluetoothState)state;


/**
 *  if manager scanned some new beacons, this method will call back.
 *
 *  @param manager a manager instance.
 *  @param beacons all new beacons.
 */
- (void)minewBeaconManager:(MinewBeaconManager * )manager appearBeacons:(NSArray<MinewBeacon *> *)beacons;

/**
 *  if a beacon didn't update any data (such as rssi/battery etc.) after 8 seconds since last
 *  update time, the manager think it has already out of the scanning range, 
 *  so this method will call back.
 *
 *  @param manager a manager instance
 *  @param beacons all disappear beacons.
 */
- (void)minewBeaconManager:(MinewBeaconManager * )manager disappearBeacons:(NSArray<MinewBeacon *> *)beacons;

/**
 *  if the manager scanned some beacons,this method call back every 1 second for giving newest 
 *  data / UI refreshing and so on.
 *
 *  @param manager a manager instance
 *  @param beacons all scanned beacons.
 */
- (void)minewBeaconManager:(MinewBeaconManager * )manager didRangeBeacons:(NSArray<MinewBeacon *> * )beacons;

@end


@interface MinewBeaconManager : NSObject

// delegate
@property (nonatomic, weak) id<MinewBeaconManagerDelegate> delegate;

// all beacons scanned.
@property (nonatomic, readonly, copy) NSArray<MinewBeacon *> *scannedBeacons;

// all beacons in range.
@property (nonatomic, readonly, copy) NSArray<MinewBeacon *> *inRangeBeacons;

// 当前的蓝牙状态
@property (nonatomic, readonly, assign) BluetoothState bluetoothState;

// a sharedinstance of the manager.
+ (MinewBeaconManager  *)sharedInstance;

// 
- (void)startScan;


- (void)stopScan;


@end
