//
//  NSObjectCategoryTestCase.m
//  Example
//
//  Created by amao on 2016/12/16.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+NTESFoundation.h"

@interface NTESSwizzleObject : NSObject
@end

@implementation NTESSwizzleObject

- (NSInteger)instanceCount {return  0;}
- (NSInteger)instanceSwizzledCount {return 1;}

- (NSInteger)instanceCount:(NSInteger)param {return param + 0;}
- (NSInteger)instanceSwizzledCount:(NSInteger)param {return param + 1;}

+ (NSInteger)classCount {return 2;}
+ (NSInteger)classSwizzledCount {return 3;}

+ (NSInteger)classCount:(NSInteger)param {return param + 4;}
+ (NSInteger)classSwizzledCount:(NSInteger)param {return param + 5;}
@end


@interface NTESCountObject : NSObject
@end
@implementation NTESCountObject
- (NSInteger)instanceCount {return  0;}
- (NSInteger)instanceCount:(NSInteger)param {return param + 0;}
+ (NSInteger)classCount {return 2;}
+ (NSInteger)classCount:(NSInteger)param {return param + 4;}
@end

@interface NTESSwizzleCountObject : NSObject
@end

@implementation NTESSwizzleCountObject
- (NSInteger)instanceSwizzledCount {return 1;}
- (NSInteger)instanceSwizzledCount:(NSInteger)param {return param + 1;}
+ (NSInteger)classSwizzledCount {return 3;}
+ (NSInteger)classSwizzledCount:(NSInteger)param {return param + 5;}
@end


@interface NSObjectCategoryTestCase : XCTestCase

@end

@implementation NSObjectCategoryTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInstanceSwizzleWithoutParam
{
    NTESSwizzleObject *object = [[NTESSwizzleObject alloc] init];
    NSInteger count = [object instanceCount];
    NSInteger swizzledCount = [object instanceSwizzledCount];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESSwizzleObject ntes_swizzleInstanceSelector:@selector(instanceCount) withSelector:@selector(instanceSwizzledCount)];
    
    XCTAssertEqual(count, [object instanceSwizzledCount]);
    XCTAssertEqual(swizzledCount, [object instanceCount]);
}


- (void)testInstanceSwizzleWithParam
{
    NSInteger param = 10;
    NTESSwizzleObject *object = [[NTESSwizzleObject alloc] init];
    NSInteger count = [object instanceCount:param];
    NSInteger swizzledCount = [object instanceSwizzledCount:param];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESSwizzleObject ntes_swizzleInstanceSelector:@selector(instanceCount:) withSelector:@selector(instanceSwizzledCount:)];
    
    XCTAssertEqual(count, [object instanceSwizzledCount:param]);
    XCTAssertEqual(swizzledCount, [object instanceCount:param]);
}


- (void)testClassSwizzleWithoutParam
{
    NSInteger count = [NTESSwizzleObject classCount];
    NSInteger swizzledCount = [NTESSwizzleObject classSwizzledCount];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESSwizzleObject ntes_swizzleClassSelector:@selector(classCount) withSelector:@selector(classSwizzledCount)];
    
    XCTAssertEqual(count, [NTESSwizzleObject classSwizzledCount]);
    XCTAssertEqual(swizzledCount, [NTESSwizzleObject classCount]);
}


- (void)testClassSwizzleWithParam
{
    NSInteger param = 10;
    NSInteger count = [NTESSwizzleObject classCount:param];
    NSInteger swizzledCount = [NTESSwizzleObject classSwizzledCount:param];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESSwizzleObject ntes_swizzleClassSelector:@selector(classCount:) withSelector:@selector(classSwizzledCount:)];
    
    XCTAssertEqual(count, [NTESSwizzleObject classSwizzledCount:param]);
    XCTAssertEqual(swizzledCount, [NTESSwizzleObject classCount:param]);

}

- (void)testInstanceSwizzleWithoutParamWithOtherClass
{
    NTESCountObject *object = [[NTESCountObject alloc] init];
    NSInteger count = [object instanceCount];
    NTESSwizzleCountObject *swizzledObject = [[NTESSwizzleCountObject alloc] init];
    NSInteger swizzledCount = [swizzledObject instanceSwizzledCount];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESCountObject ntes_swizzleInstanceSelector:@selector(instanceCount)
                                    swizzledClass:[NTESSwizzleCountObject class]
                                 swizzledSelector:@selector(instanceSwizzledCount)];
    
    XCTAssertEqual(count, [swizzledObject instanceSwizzledCount]);
    XCTAssertEqual(swizzledCount, [object instanceCount]);
}


- (void)testInstanceSwizzleWithParamithOtherClass
{
    NSInteger param = 10;
     NTESCountObject *object = [[NTESCountObject alloc] init];
    NTESSwizzleCountObject *swizzledObject = [[NTESSwizzleCountObject alloc] init];
    NSInteger count = [object instanceCount:param];
    NSInteger swizzledCount = [swizzledObject instanceSwizzledCount:param];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESCountObject ntes_swizzleInstanceSelector:@selector(instanceCount:)
                                    swizzledClass:[NTESSwizzleCountObject class]
                                 swizzledSelector:@selector(instanceSwizzledCount:)];

    
    XCTAssertEqual(count, [swizzledObject instanceSwizzledCount:param]);
    XCTAssertEqual(swizzledCount, [object instanceCount:param]);
}


- (void)testClassSwizzleWithoutParamithOtherClass
{
    NSInteger count = [NTESCountObject classCount];
    NSInteger swizzledCount = [NTESSwizzleCountObject classSwizzledCount];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESCountObject ntes_swizzleClassSelector:@selector(classCount)
                                 swizzledClass:[NTESSwizzleCountObject class]
                              swizzledSelector:@selector(classSwizzledCount)];
     
    XCTAssertEqual(count, [NTESSwizzleCountObject classSwizzledCount]);
    XCTAssertEqual(swizzledCount, [NTESCountObject classCount]);
}


- (void)testClassSwizzleWithParamithOtherClass
{
    NSInteger param = 10;
    NSInteger count = [NTESCountObject classCount:param];
    NSInteger swizzledCount = [NTESSwizzleCountObject classSwizzledCount:param];
    
    XCTAssertNotEqual(count, swizzledCount);
    
    [NTESCountObject ntes_swizzleClassSelector:@selector(classCount:)
                                 swizzledClass:[NTESSwizzleCountObject class]
                              swizzledSelector:@selector(classSwizzledCount:)];
    
    XCTAssertEqual(count, [NTESSwizzleCountObject classSwizzledCount:param]);
    XCTAssertEqual(swizzledCount, [NTESCountObject classCount:param]);
    
}

@end
