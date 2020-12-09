//
//  NTESServiceCenterTestCase.m
//  Example
//
//  Created by amao on 2017/1/10.
//  Copyright © 2017年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESFoundation.h"


@protocol NTESTestAProtoocl <NSObject>
@end

@protocol NTESTestBProtocol <NSObject>
@end


@interface NTESTestA : NSObject <NTESTestAProtoocl>

@end

@implementation NTESTestA

@end

@interface NTESServiceCenterTestCase : XCTestCase

@end

@implementation NTESServiceCenterTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidService
{
    NTESServiceCenter *center = [[NTESServiceCenter alloc] init];
    [center registerService:@protocol(NTESTestAProtoocl) implClass:[NTESTestA class]];
    
    id<NTESTestAProtoocl> service1 = [center serviceByProtocol:@protocol(NTESTestAProtoocl)];
    id<NTESTestAProtoocl> service2 = [center serviceByProtocol:@protocol(NTESTestAProtoocl)];
    
    XCTAssertNotNil(service1);
    XCTAssertNotNil(service2);
    XCTAssertEqual(service1, service2);
    XCTAssertTrue([service1 isKindOfClass:[NTESTestA class]]);
}

- (void)testInvalidService
{
    NTESServiceCenter *center = [[NTESServiceCenter alloc] init];
    center.exceptionEnabled = NO;
    [center registerService:@protocol(NTESTestBProtocol) implClass:[NTESTestA class]];
    
    id<NTESTestAProtoocl> service1 = [center serviceByProtocol:@protocol(NTESTestAProtoocl)];
    id<NTESTestAProtoocl> service2 = [center serviceByProtocol:@protocol(NTESTestAProtoocl)];
    
    XCTAssertNil(service1);
    XCTAssertNil(service2);
}
@end
