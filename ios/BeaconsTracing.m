#import "BeaconsTracing.h"
#import <Gimbal/Gimbal.h>
#import "GimbalInitializer.h"

@implementation BeaconsTracing

RCT_EXPORT_MODULE()

// Example method
// See // https://facebook.github.io/react-native/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}

RCT_REMAP_METHOD(initialiseFramework)
{
  [[GimbalInitializer sharedInstance] intialiseGimbalFramework];
}

RCT_REMAP_METHOD(findEvents:(RCTResponseSenderBlock)callback)
{
  dispatch_async(dispatch_get_main_queue(), ^{

  callback(@[[NSNull null], [[GimbalInitializer sharedInstance] sendEvents]]);
    });

}

RCT_REMAP_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

@end
