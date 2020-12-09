//
//  NTESStopWatchTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/10/12.
//  Copyright © 2018 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

@interface NTESStopWatchTestCase : XCTestCase

@end

@implementation NTESStopWatchTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


- (void)testStopWatch
{
    {
        NTESStopWatch *stopWatch = [NTESStopWatch new];
        sleep(2);
        CFTimeInterval duration1 = [stopWatch stop];
        XCTAssertTrue(duration1 > 1.8 && duration1 < 2.2);
        sleep(3);
        CFTimeInterval duration2 = [stopWatch stop];
        XCTAssertTrue(duration2 > 2.8 && duration1 < 3.2);

    }
    
    {
        NTESStopWatch *stopWatch = [NTESStopWatch new];
        [stopWatch stop:nil];
        [stopWatch stop:@"stop me %@",stopWatch];
    }
}

@end
