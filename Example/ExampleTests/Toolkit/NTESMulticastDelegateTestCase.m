//
//  NTESMulticastDelegateTestCase.m
//  Example
//
//  Created by amao on 2016/12/20.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

@protocol NTESTestMulticastDelegate <NSObject>
- (void)callback:(NSMutableArray *)items;
@end


@interface NTESTestMulticastDelegateA : NSObject<NTESTestMulticastDelegate>
@end

@implementation NTESTestMulticastDelegateA
- (void)callback:(NSMutableArray *)items
{
    [items addObject:[NSNull null]];
}
@end

@interface NTESTestMulticastDelegateC : NSObject
@end

@implementation NTESTestMulticastDelegateC
@end

@interface NTESMulticastDelegateTestCase : XCTestCase

@end

@implementation NTESMulticastDelegateTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


- (void)testMulticastCallback
{
    NTESMulticastDelegate *delegate = [[NTESMulticastDelegate alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    
    NTESTestMulticastDelegateA *a = [[NTESTestMulticastDelegateA alloc] init];
    [delegate addDelegate:a];
    
    NTESTestMulticastDelegateA *b = [[NTESTestMulticastDelegateA alloc] init];
    [delegate addDelegate:b];
    
    [(id<NTESTestMulticastDelegate>)delegate callback:items];
    
    XCTAssertEqual([items count], 2);
}


- (void)testAddSameDelegate
{
    NTESMulticastDelegate *delegate = [[NTESMulticastDelegate alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    
    NTESTestMulticastDelegateA *a = [[NTESTestMulticastDelegateA alloc] init];
    [delegate addDelegate:a];
    [delegate addDelegate:a];
    
    [(id<NTESTestMulticastDelegate>)delegate callback:items];
    
    XCTAssertEqual([items count], 1);
}


- (void)testAddInvalidDelegate
{
    NTESMulticastDelegate *delegate = [[NTESMulticastDelegate alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    
    NTESTestMulticastDelegateA *a = [[NTESTestMulticastDelegateA alloc] init];
    [delegate addDelegate:a];
    
    NTESTestMulticastDelegateC *c = [[NTESTestMulticastDelegateC alloc] init];
    [delegate addDelegate:c];
    
    [(id<NTESTestMulticastDelegate>)delegate callback:items];
    
    XCTAssertEqual([items count], 1);
}
@end
