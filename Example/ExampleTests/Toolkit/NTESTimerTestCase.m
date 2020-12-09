//
//  NTESTimerTestCase.m
//  Example
//
//  Created by amao on 2016/12/20.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESUtility.h"
#import <NTESFoundation/NTESFoundation.h>

@interface NTESTimerTestCase : XCTestCase<NTESTimerDelegate>
@property (nonatomic,strong)    NTESTimer *repeatableTimer;
@property (nonatomic,strong)    NTESTimer *nonRepeatableTimer;
@property (nonatomic,assign)    NSInteger repeatableCount;
@property (nonatomic,assign)    NSInteger nonrepeatableCount;
@end

@implementation NTESTimerTestCase

- (void)setUp {
    [super setUp];
    
    _repeatableTimer = [[NTESTimer alloc] init];
    _nonRepeatableTimer = [[NTESTimer alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRepeatableTimer
{
    [_repeatableTimer startTimer:0.3
                        delegate:self
                         repeats:YES];
    
    //考虑误差
    NTES_WAIT_WHILE((_repeatableCount < 20), 10);
    
    
}

- (void)testNonRepeatableTimer
{
    [_nonRepeatableTimer startTimer:0.3
                           delegate:self
                            repeats:NO];
    
    NSDate *giveDate = [NSDate dateWithTimeIntervalSinceNow:1];
    while ([giveDate timeIntervalSinceNow] > 0)
    {
        NSDate *loopIntervalDate = [NSDate dateWithTimeIntervalSinceNow:0.01];
        [[NSRunLoop currentRunLoop] runUntilDate:loopIntervalDate];
    }
    XCTAssertTrue(_nonrepeatableCount == 1);
    

}

- (void)onNTESTimerFired:(NTESTimer *)timer
{
    if (_repeatableTimer == timer)
    {
        _repeatableCount++;
    }
    else if(_nonRepeatableTimer == timer)
    {
        _nonrepeatableCount++;
        XCTAssertTrue(_nonrepeatableCount <= 1);
    }
}



@end
