//
//  UIViewCategoryTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/6/20.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+NTESFoundation.h"


#define CGFLOATEQUAL(x,y)   (fabs((x) - (y)) < 0.0000001)
#define XCTAssertFloatEqual(x,y) XCTAssertTrue(CGFLOATEQUAL(x,y))

@interface UIViewCategoryTestCase : XCTestCase

@end

@implementation UIViewCategoryTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 23, 34, 45)];
    
    XCTAssertFloatEqual(view.ntes_left   ,view.frame.origin.x);
    XCTAssertFloatEqual(view.ntes_top    ,view.frame.origin.y);
    XCTAssertFloatEqual(view.ntes_right  ,view.frame.origin.x + view.frame.size.width);
    XCTAssertFloatEqual(view.ntes_bottom ,view.frame.origin.y + view.frame.size.height);
    XCTAssertFloatEqual(view.ntes_width  ,view.frame.size.width);
    XCTAssertFloatEqual(view.ntes_height ,view.frame.size.height);
    XCTAssertFloatEqual(view.ntes_centerX,view.center.x);
    XCTAssertFloatEqual(view.ntes_centerY,view.center.y);
    XCTAssertFloatEqual(view.ntes_origin.x,view.frame.origin.x);
    XCTAssertFloatEqual(view.ntes_origin.y,view.frame.origin.y);
    XCTAssertFloatEqual(view.ntes_size.width,view.frame.size.width);
    XCTAssertFloatEqual(view.ntes_size.height,view.frame.size.height);
}

- (void)testSetter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 23, 34, 45)];
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_left = value;
        XCTAssertFloatEqual(view.ntes_left,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_top = value;
        XCTAssertFloatEqual(view.ntes_top,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_right = value;
        XCTAssertFloatEqual(view.ntes_right,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_bottom = value;
        XCTAssertFloatEqual(view.ntes_bottom,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_width = value;
        XCTAssertFloatEqual(view.ntes_width,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_height = value;
        XCTAssertFloatEqual(view.ntes_height,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_centerX = value;
        XCTAssertFloatEqual(view.ntes_centerX,value);
    }
    {
        CGFloat value = (CGFloat)(arc4random() / 1000.0);
        view.ntes_centerY = value;
        XCTAssertFloatEqual(view.ntes_centerY,value);
    }
    {
        CGFloat x = (CGFloat)(arc4random() / 1000.0);
        CGFloat y = (CGFloat)(arc4random() / 1000.0);
        view.ntes_origin = CGPointMake(x, y);
        XCTAssertFloatEqual(view.ntes_origin.x,x);
        XCTAssertFloatEqual(view.ntes_origin.y,y);
        

    }
    {
        CGFloat x = (CGFloat)(arc4random() / 1000.0);
        CGFloat y = (CGFloat)(arc4random() / 1000.0);
        view.ntes_size = CGSizeMake(x, y);
        XCTAssertFloatEqual(view.ntes_size.width,x);
        XCTAssertFloatEqual(view.ntes_size.height,y);
    }
}



@end
