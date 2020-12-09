//
//  NTESNSStringTestCase.m
//  Example
//
//  Created by amao on 2016/12/19.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+NTESFoundation.h"
#import "NTESUtility.h"

@interface NSStringCategoryTestCase : XCTestCase

@end

@implementation NSStringCategoryTestCase

- (void)setUp {
    [super setUp];
    [NTESUtility swizzleMainBundle];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPathInMainBundle
{
    {
        NSString *path = [NSString ntes_pathInMainBundle:@"video.mp4"];
        NSString *mainBundlePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
        XCTAssertTrue([path isEqualToString:mainBundlePath],@"wrong path %@",path);
    }
    
    {
        NSString *path = [NSString ntes_pathInMainBundle:@"video"];
        XCTAssertNil(path);
    }
    
    {
        NSString *path = [NSString ntes_pathInMainBundle:@"video.MP4"];
        XCTAssertNil(path);
    }
}

- (void)testTrim
{
    {
        NSString *str = @" NTESFoundation";
        NSString *result = [str ntes_trim];
        XCTAssertTrue([result isEqualToString:@"NTESFoundation"],@"result is %@",result);
    }
    
    {
        NSString *str = @"  NTESFoundation";
        NSString *result = [str ntes_trim];
        XCTAssertTrue([result isEqualToString:@"NTESFoundation"],@"result is %@",result);
    }
    
    {
        NSString *str = @"NTESFoundation ";
        NSString *result = [str ntes_trim];
        XCTAssertTrue([result isEqualToString:@"NTESFoundation"],@"result is %@",result);
    }
    
    {
        NSString *str = @"NTESFoundation  ";
        NSString *result = [str ntes_trim];
        XCTAssertTrue([result isEqualToString:@"NTESFoundation"],@"result is %@",result);
    }
    
    
    {
        NSString *str = @" NTESFoundation ";
        NSString *result = [str ntes_trim];
        XCTAssertTrue([result isEqualToString:@"NTESFoundation"],@"result is %@",result);
    }
}

- (void)testMD5
{
    {
        NSString *str = @"NTESFoundation";
        NSString *md5 = [str ntes_md5];
        XCTAssertTrue([md5 isEqualToString:@"0d6a5ec04fec05250c34b0632f3daec6"],@"md5 is %@",md5);
    }
    
    {
        NSString *str = @"NTES基础库";
        NSString *md5 = [str ntes_md5];
        XCTAssertTrue([md5 isEqualToString:@"6f597fd4a88a4685723ad544ea365c59"],@"md5 is %@",md5);
    }

}

- (void)testSha1
{
    {
        NSString *str = @"NTESFoundation";
        NSString *sha1 = [str ntes_sha1];
        XCTAssertTrue([sha1 isEqualToString:@"b1b1a946cffcf03b09afcdff25ab11a5af43b6fd"],@"sha1 is %@",sha1);
    }
    
    {
        NSString *str = @"NTES基础库";
        NSString *sha1 = [str ntes_sha1];
        XCTAssertTrue([sha1 isEqualToString:@"8b7c76e7c99f49112f7ffaa35f3a7cef036d7011"],@"sha1 is %@",sha1);
    }

}

- (void)testHexToBinary
{
    unsigned char key[32] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
        0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F};
    NSString *str = [@"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F" lowercaseString];
    NSData *result = [str ntes_hexToBinary];
    NSData *data = [NSData dataWithBytes:key length:32];
    
    XCTAssertTrue([result isEqualToData:data]);
}

- (void)testValidIdentificationCard
{
    {

    NSString *str = @"110102199801014838";
    BOOL result = [str ntes_validIdentificationCard];
    XCTAssertTrue(result == YES,@"valid IdentificationCard is %@",str);
    }
    
    {
    NSString *str = @"12121212121212121";
    BOOL result = [str ntes_validIdentificationCard];
    XCTAssertTrue(result == NO,@"inValid IdentificationCard is %@",str);
    }

}
- (void)testValidEmail
{
    {
        NSString *str = @"1212@qq.com";
        BOOL result = [str ntes_validEmail];
        XCTAssertTrue(result == YES,@"valid Email is %@",str);
    }
    
    {
        NSString *str = @"12121212121aaaa";
        BOOL result = [str ntes_validEmail];
        XCTAssertTrue(result == NO,@"inValid Email is %@",str);
    }
}
- (void)testValidPostcode
{
    {
        NSString *str = @"100005";
        BOOL result = [str ntes_validPostcode];
        XCTAssertTrue(result == YES,@"valid Postcode is %@",str);
    }
    
    {
        NSString *str = @"assss";
        BOOL result = [str ntes_validPostcode];
        XCTAssertTrue(result == NO,@"inValid Postcode is %@",str);
    }
}

- (void)testValidIPv4
{
    {
        NSString *str = @"129.111.222.111";
        BOOL result = [str ntes_validIPv4];
        XCTAssertTrue(result == YES,@"valid IPV4 is %@",str);
    }
    
    {
        NSString *str = @"asasasasas.11.22.22";
        BOOL result = [str ntes_validIPv4];
        XCTAssertTrue(result == NO,@"inValid IPV4 is %@",str);
    }
}

- (void)testIsEqualToStringSwizzle
{
    {
        NSString *a = @"123";
        NSString *b = @"123";
        XCTAssertTrue([a isEqualToString:b]);
    }
    
    {
        NSString *a = nil;
        NSString *b = @"123";
        XCTAssertFalse([a isEqualToString:b]);
    }
    
    {
        NSString *a = @"123";
        NSString *b = nil;
        XCTAssertFalse([a isEqualToString:b]);
    }
}

- (void)testStringURLEncoding
{
    {
        NSString *input = @"http://cps.kaola.com/cps/login?unionId=999684145434&uid=e81b9c847d7248b8a10a5ee03f0bbcfe&trackingCode=&targetUrl=http%3A%2F%2Fwww.kaola.com%2Fproduct%2F1456396.html";
        
        NSString *output = @"http%3A%2F%2Fcps.kaola.com%2Fcps%2Flogin%3FunionId%3D999684145434%26uid%3De81b9c847d7248b8a10a5ee03f0bbcfe%26trackingCode%3D%26targetUrl%3Dhttp%253A%252F%252Fwww.kaola.com%252Fproduct%252F1456396.html";
        
        NSString *result = [input ntes_stringByURLEncoding];
        XCTAssertTrue([output isEqualToString:result],@"%@ not equals to %@",output,result);
    }
    
    
    {
        NSString *input = @"https://zh.wikipedia.org/wiki/百分号编码";
        NSString *output = [input ntes_stringByURLEncoding];
        {
            NSURL *url = [NSURL URLWithString:input];
            XCTAssertNil(url);
        }
        
        {
            NSURL *url = [NSURL URLWithString:output];
            XCTAssertNotNil(url);
        }
    }
    
    {
        NSString *input = @"https://zh.wikipedia.org/w/index.php?title=百分号编码&action=edit";
        NSString *output = [input ntes_stringByURLEncoding];
        {
            NSURL *url = [NSURL URLWithString:input];
            XCTAssertNil(url);
        }
        
        {
            NSURL *url = [NSURL URLWithString:output];
            XCTAssertNotNil(url);
        }
    }
}


@end
