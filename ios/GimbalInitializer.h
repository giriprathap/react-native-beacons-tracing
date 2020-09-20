//
//  GimbalInitializer.h
//  myElthApp
//
//  Created by Varakavi, Giriprathap (IN) on 20/09/20.
//

#import <Foundation/Foundation.h>
#import <Gimbal/Gimbal.h>

NS_ASSUME_NONNULL_BEGIN

@interface GimbalInitializer : NSObject<GMBLPlaceManagerDelegate, GMBLCommunicationManagerDelegate>

@property (nonatomic) GMBLPlaceManager *placeManager;
@property (nonatomic) GMBLCommunicationManager *communicationManager;
@property (nonatomic) NSArray *events;
@property CLLocationManager *locationManager;


-(NSArray *)sendEvents;
-(void)intialiseGimbalFramework;
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
