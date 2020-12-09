//
//  NTESUtility.h
//  Example
//
//  Created by amao on 2016/12/19.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <Foundation/Foundation.h>


#define NTES_TEST_NOTIFY_KEY (@"nim_test_notification")

#define NTES_TEST_WAIT_WITH_KEY(key)\
{\
[self expectationForNotification:(key) object:nil handler:nil];\
[self waitForExpectationsWithTimeout:180 handler:nil];\
}

#define NTES_TEST_NOTIFY_WITH_KEY(key)\
{\
dispatch_async(dispatch_get_main_queue(), ^{ \
[[NSNotificationCenter defaultCenter] postNotificationName:(key) object:nil];\
});\
}


#define NTES_TEST_WAIT       NTES_TEST_WAIT_WITH_KEY(NTES_TEST_NOTIFY_KEY)
#define NTES_TEST_NOTIFY     NTES_TEST_NOTIFY_WITH_KEY(NTES_TEST_NOTIFY_KEY)


#define NTES_WAIT_WHILE(whileTrue, limitInSeconds) \
{\
NSDate *giveUpDate = [NSDate dateWithTimeIntervalSinceNow:(limitInSeconds)];\
while ((whileTrue) && [giveUpDate timeIntervalSinceNow] > 0)\
{\
NSDate *loopIntervalDate = [NSDate dateWithTimeIntervalSinceNow:0.01];\
[[NSRunLoop currentRunLoop] runUntilDate:loopIntervalDate];\
}\
if((whileTrue)) \
{\
XCTAssertNil(@"invalid path");\
}\
}\



@interface NTESUtility : NSObject
+ (void)swizzleMainBundle;
@end
