//
//  NTESMacroTestCase.m
//  Example
//
//  Created by amao on 2017/1/4.
//  Copyright © 2017年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

@interface NTESMacroTestCase : XCTestCase

@end

@implementation NTESMacroTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testColor
{
    {
        UIColor *src = NTESRGB(0x123456);
        UIColor *dst = [UIColor colorWithRed:0x12/255.0
                                       green:0x34/255.0
                                        blue:0x56/255.0
                                       alpha:1];
        [self compare:src
                  dst:dst];
    }
    
    {
        UIColor *src = NTESRGBA(0x123456,0.112);
        UIColor *dst = [UIColor colorWithRed:0x12/255.0
                                       green:0x34/255.0
                                        blue:0x56/255.0
                                       alpha:0.112];
        [self compare:src
                  dst:dst];
    }
}

- (void)compare:(UIColor *)src
            dst:(UIColor *)dst
{
    CGFloat r,g,b,a;
    CGFloat dr,dg,db,da;
    [src getRed:&r green:&g blue:&b alpha:&a];
    [dst getRed:&dr green:&dg blue:&db alpha:&da];
    
    XCTAssertTrue(fabs(r - dr) < 0.00001,@"r %f vs dr %f",r,dr);
    XCTAssertTrue(fabs(g - dg) < 0.00001,@"g %f vs dg %f",g,dg);
    XCTAssertTrue(fabs(b - db) < 0.00001,@"b %f vs db %f",b,db);
    XCTAssertTrue(fabs(a - da) < 0.00001,@"a %f vs da %f",a,da);
    
    
}
@end
