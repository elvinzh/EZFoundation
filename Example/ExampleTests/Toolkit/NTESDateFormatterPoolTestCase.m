//
//  NTESObjectPoolTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/7/2.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

@interface NTESObjectPoolTestCase : XCTestCase
@property (nonatomic,assign)    NSInteger   times;
@end

@implementation NTESObjectPoolTestCase

- (void)setUp {
    [super setUp];
    _times = 100;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFormatter
{
    NSString *format = @"YYYY-MM-dd";
    NSDateFormatter *formatterInPool = [[NTESObjectPool shared] formatter:format];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSDate *date = [NSDate date];
    NSString *dateText = [formatter stringFromDate:date];
    NSString *dateTextInPool = [formatterInPool stringFromDate:date];
    
    XCTAssertTrue([dateText isEqualToString:dateTextInPool]);
}

- (void)testFormatterPoolPerformance{
    [self measureBlock:^{
        NSDate *date = [NSDate date];
        NSString *format = @"YYYY-MM-dd";
        for (NSInteger i = 0; i < self.times; i++)
        {
            NSDateFormatter *formatterInPool = [[NTESObjectPool shared] formatter:format];
            NSString *text = [formatterInPool stringFromDate:date];
            NSLog(@"%@",text);
        }
    }];
}

- (void)testFormatterPerformance{
    [self measureBlock:^{
        NSDate *date = [NSDate date];
        NSString *format = @"YYYY-MM-dd";
        for (NSInteger i = 0; i < self.times; i++)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            NSString *text = [formatter stringFromDate:date];
            NSLog(@"%@",text);
        }
    }];
}

@end
