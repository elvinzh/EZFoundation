//
//  UIImageCategoryTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/7/25.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>
#import <UIKit/UIKit.h>


@interface UIImageCategoryTestCase : XCTestCase
@property (nonatomic,strong)    UIImage *image;
@end

@implementation UIImageCategoryTestCase

- (void)setUp {
    [super setUp];
    
    CGRect rect = CGRectMake(0, 0, 200, 400);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [[UIColor redColor] setFill];
    UIRectFill(rect);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)tearDown {
    [super tearDown];
}

- (void)testImageScale
{
    CGSize size = CGSizeMake(100, 100);
    CGFloat pixels = 200 * 100;
    
    {
        UIImage *result = [self.image ntes_internalScaled:size];
        XCTAssertNotNil(result);
        XCTAssertTrue(CGSizeEqualToSize(result.size, CGSizeMake(50, 100)));
        XCTAssertTrue(result.scale == self.image.scale);
    }
    
    {
        UIImage *result = [self.image ntes_externalScaled:size];
        XCTAssertNotNil(result);
        XCTAssertTrue(CGSizeEqualToSize(result.size, CGSizeMake(100, 200)));
        XCTAssertTrue(result.scale == self.image.scale);
    }
    
    {
        UIImage *result = [self.image ntes_scaledWithPixels:pixels];
        XCTAssertNotNil(result);
        CGFloat diff = fabs(result.size.width * result.size.height - pixels);
        XCTAssertTrue(diff < 0.00001);
        XCTAssertTrue(result.scale == self.image.scale);
    }
    
}

- (void)testLargeImageScale
{
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"huge" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImage *result = [image ntes_scaledWithPixels:1920 * 1080];
    XCTAssertTrue(result.size.width * result.size.height <= 1920 * 1080);
}

@end
