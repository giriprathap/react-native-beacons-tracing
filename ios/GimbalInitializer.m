//
//  GimbalInitializer.m
//  myElthApp
//
//  Created by Varakavi, Giriprathap (IN) on 20/09/20.
//

#import "GimbalInitializer.h"

@implementation GimbalInitializer

+ (instancetype)sharedInstance
{
    static GimbalInitializer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GimbalInitializer alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(void)intialiseGimbalFramework{
  
      [Gimbal setAPIKey:@"3f939682-bd82-4565-87af-2c7d4a0f0cd4" options:nil];
      [Gimbal start];

      self.placeManager = [GMBLPlaceManager new];
      self.placeManager.delegate = self;
      self.communicationManager = [GMBLCommunicationManager new];
      self.communicationManager.delegate = self;
      
      // Request for Location Access...
      [self initializeCoreLocationManager];
}

-(void)initializeCoreLocationManager{
  self.locationManager = [[CLLocationManager alloc] init];
  [self.locationManager requestWhenInUseAuthorization];
}

# pragma mark - Gimbal PlaceManager delegate methods

- (void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit
{
    [self addEventWithMessage:visit.place.name date:visit.arrivalDate icon:@"placeEnter"];
}

- (void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit
{
    [self addEventWithMessage:visit.place.name date:visit.departureDate icon:@"placeExit"];
}

- (void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit withDelay:(NSTimeInterval)delayTime
{
    if (delayTime > 5.0){
        [self addEventWithMessage:[@"Delay: " stringByAppendingString:visit.place.name]  date:[NSDate date] icon:@"placeDelay"];
    }
}

# pragma mark -  Notificaion Helper Methods

//- (void)processRemoteNotification:(NSDictionary *)userInfo
//{
//    GMBLCommunication *communication = [GMBLCommunicationManager communicationForRemoteNotification:userInfo];
//
//    if (communication)
//    {
//        [self storeCommunication:communication];
//    }
//}
//
//- (void)processNotificationResponse:(UNNotificationResponse *)response
//{
//    GMBLCommunication *communication = [GMBLCommunicationManager communicationForNotificationResponse:response];
//    if (communication)
//    {
//        [self storeCommunication:communication];
//    }
//}
//
//- (void)processLocalNotification:(UILocalNotification *)notification withApplicationState:(UIApplicationState)state
//{
//    GMBLCommunication *communication = [GMBLCommunicationManager communicationForLocalNotification:notification];
//
//    if (communication)
//    {
//        [[UIApplication sharedApplication] cancelLocalNotification:notification];
//        [self storeCommunication:communication];
//    }
//}
//
//- (void)storeCommunication:(GMBLCommunication *)communication
//{
//
//}



- (void)addEventWithMessage:(NSString *)message date:(NSDate *)date icon:(NSString *)icon
{
    NSDictionary *item = @{@"message":message, @"date":date, @"icon":icon};
    
    NSLog(@"Event %@",[item description]);
    
    NSMutableArray *events = [NSMutableArray arrayWithArray:self.events];
    [events insertObject:item atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:events forKey:@"events"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.events = events;

}


-(NSArray *)sendEvents{

  if(self.events.count!=0){
    return self.events;

  }
  return @[];
}


@end
