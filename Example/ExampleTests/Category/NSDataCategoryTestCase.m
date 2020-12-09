//
//  NSDataCategoryTestCase.m
//  Example
//
//  Created by amao on 2016/12/19.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+NTESFoundation.h"
#import "NTESUtility.h"

@interface NSDataCategoryTestCase : XCTestCase

@end

@implementation NSDataCategoryTestCase

- (void)setUp {
    [super setUp];
    
    [NTESUtility swizzleMainBundle];
   
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMD5
{
    {
        NSString *str = @"NTESFoundation";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSString *md5 = [data ntes_md5];
        XCTAssertTrue([md5 isEqualToString:@"0d6a5ec04fec05250c34b0632f3daec6"],@"md5 is %@",md5);
    }
    {
        NSString *str = @"NTES基础库";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSString *md5 = [data ntes_md5];
        XCTAssertTrue([md5 isEqualToString:@"6f597fd4a88a4685723ad544ea365c59"],@"md5 is %@",md5);
    }

}

- (void)testSha1
{
    {
        NSString *str = @"NTESFoundation";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSString *sha1 = [data ntes_sha1];
        XCTAssertTrue([sha1 isEqualToString:@"b1b1a946cffcf03b09afcdff25ab11a5af43b6fd"],@"sha1 is %@",sha1);
    }
    
    {
        NSString *str = @"NTES基础库";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSString *sha1 = [data ntes_sha1];
        XCTAssertTrue([sha1 isEqualToString:@"8b7c76e7c99f49112f7ffaa35f3a7cef036d7011"],@"sha1 is %@",sha1);
    }

}

- (void)testBinaryToHex
{
    unsigned char key[32] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
                             0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F};
    NSString *result = [@"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F" lowercaseString];
    
    NSData *data = [NSData dataWithBytes:key length:32];
    NSString *hex = [data ntes_binaryToHex];
    XCTAssertTrue([hex isEqualToString:result],@"hex is %@",hex);
}

- (void)testDataInMainBundle
{
    {
        NSString *fileMD5 = @"f67114a4486c3b22bc6b29d61a27f3dd";
        NSData *data = [NSData ntes_dataInMainBundle:@"video.mp4"];
        NSString *md5 = [data ntes_md5];
        XCTAssertTrue([fileMD5 isEqualToString:md5],@"calculated md5 is %@",md5);
    }
    
    {
        NSData *data = [NSData ntes_dataInMainBundle:@"video"];
        XCTAssertNil(data);
    }
    
    {
        NSData *data = [NSData ntes_dataInMainBundle:@"video.MP4"];
        XCTAssertNil(data);
    }

}
@end
