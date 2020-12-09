//
//  NSArrayCategoryTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/7/16.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

@interface NSArrayCategoryTestCase : XCTestCase

@end

@implementation NSArrayCategoryTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testMap
{
    NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
    NSArray<NSString *> *strings = @[@"1",@"2",@"3",@"4"];
    
    {
        NSArray *result =  [numbers ntes_map:^id _Nonnull(NSNumber * _Nonnull objc) {
            return [objc stringValue];
        }];
        XCTAssertEqualObjects(result, strings);
    }
    
    {
        
        NSArray *result =  [strings ntes_map:^id _Nonnull(NSString * _Nonnull objc) {
            return @(objc.integerValue);
        }];
        
        XCTAssertEqualObjects(result, numbers);
    }
}

- (void)testFilter
{
    NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
    NSArray *result = [numbers ntes_filter:^BOOL(NSNumber * _Nonnull objc) {
        return objc.integerValue % 2 == 0;
    }];
    NSArray *excepted = @[@2,@4];
    XCTAssertEqualObjects(result, excepted);
    
}

- (void)testReduce
{
    NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
    NSNumber *result = [numbers ntes_reduce:@(0)
                                    combine:^id _Nonnull(id  _Nonnull result, NSNumber * _Nonnull element) {
                                        return @([(NSNumber *)result integerValue] + element.integerValue);
                                    }];
    XCTAssertEqualObjects(result, @(10));
}

- (void)testAllObjectsClass
{
    {
        NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
        BOOL result = [numbers ntes_allObjectAreKindOf:[NSNumber class]];
        XCTAssertTrue(result);
    }
    
    {
        NSArray<NSNumber *> *numbers = @[];
        BOOL result = [numbers ntes_allObjectAreKindOf:[NSNumber class]];
        XCTAssertFalse(result);
    }
    
    {
        NSArray *numbers = @[@1,@"2",@3];
        BOOL result = [numbers ntes_allObjectAreKindOf:[NSNumber class]];
        XCTAssertFalse(result);
    }
}


- (void)testArrayInsert
{
    {
        NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
        NSArray<NSNumber *> *expect = @[@0,@1,@2,@3,@4];
        NSArray *result = [numbers ntes_arrayByInsertingObject:@0
                                                       atIndex:0];
        XCTAssertEqualObjects(expect, result);
        
    }
    
    {
        NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
        NSArray<NSNumber *> *expect = @[@1,@0,@2,@3,@4];
        NSArray *result = [numbers ntes_arrayByInsertingObject:@0
                                                       atIndex:1];
        XCTAssertEqualObjects(expect, result);
        
    }
    
    {
        NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
        NSArray<NSNumber *> *expect = @[@1,@2,@3,@4,@0];
        NSArray *result = [numbers ntes_arrayByInsertingObject:@0
                                                       atIndex:4];
        XCTAssertEqualObjects(expect, result);
        
    }
    
    {
        NSArray<NSNumber *> *numbers = @[@1,@2,@3,@4];
        NSArray<NSNumber *> *expect = @[@1,@2,@3,@4];
        NSArray *result = [numbers ntes_arrayByInsertingObject:@0
                                                       atIndex:5];
        XCTAssertEqualObjects(expect, result);
        
    }
}
@end
