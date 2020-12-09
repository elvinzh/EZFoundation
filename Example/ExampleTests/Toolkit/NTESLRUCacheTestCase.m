//
//  NTESLRUCacheTestCase.m
//  ExampleTests
//
//  Created by amao on 2019/2/13.
//  Copyright © 2019 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

@interface NTESLRUCacheTestCase : XCTestCase

@end

@implementation NTESLRUCacheTestCase

- (void)testZeroCapacityCase
{
    NSInteger maxCount = 100;
    NTESLRUCache *cache = [[NTESLRUCache alloc] init];
    
    for (NSInteger i = 0; i < maxCount; i++)
    {
        [cache setObject:@(i) forKey:@(i)];
        NSInteger count = i + 1;
        XCTAssertTrue([cache count] == count,@"count %d vs %d",(int)[cache count],(int)count);
    }
    XCTAssertTrue([cache count] == maxCount,@"count %d vs %d",(int)[cache count],(int)maxCount);
    
    NSInteger capacity = [cache count];
    for (NSInteger i = 0; i < maxCount / 3; i++)
    {
        [cache removeObjectForKey:@(i)];
        capacity--;
        XCTAssertTrue([cache count] == capacity,@"count %d vs %d",(int)[cache count],(int)capacity);
    }
    [cache testConsistency];
    
    for (NSInteger i = maxCount - 1; i > maxCount  * 2 / 3; i--)
    {
        [cache removeObjectForKey:@(i)];
        capacity--;
        XCTAssertTrue([cache count] == capacity,@"count %d vs %d",(int)[cache count],(int)capacity);
    }
    [cache testConsistency];
    
}


- (void)testManyCapacityCases
{
    NSInteger maxCount = 100;
    for (NSInteger capacity = 1; capacity < 20; capacity++)
    {
        NTESLRUCache *cache = [[NTESLRUCache alloc] initWithCapacity:capacity];

        
        for (NSInteger i = 0; i < maxCount; i++)
        {
            [cache setObject:@(i) forKey:@(i)];
            NSInteger count = i + 1 < capacity ? i + 1 : capacity;
            XCTAssertTrue([cache count] == count,@"count %d vs %d",(int)[cache count],(int)count);
        }
        [cache testConsistency];
        
        for (NSInteger i = 0; i < maxCount / 2; i++)
        {
            [cache removeObjectForKey:@(i)];//移除先进数据，无效
            XCTAssertTrue([cache count] == capacity,@"count %d vs %d",(int)[cache count],(int)capacity);
        }
        [cache testConsistency];
        
        [cache removeAllObjects];
        [cache testConsistency];
        
        for (NSInteger i = 0; i < maxCount; i++)
        {
            [cache setObject:@(i) forKey:@(i)];
            NSInteger count = i + 1 < capacity ? i + 1 : capacity;
            XCTAssertTrue([cache count] == count,@"count %d vs %d",(int)[cache count],(int)count);
        }
        [cache testConsistency];
        
        NSInteger count = [cache count];
        for (NSInteger i = maxCount-1; i > maxCount / 2; i--)
        {
            [cache removeObjectForKey:@(i)]; //移除后进数据，-1
            count = count - 1 < 0 ? 0 : count - 1;
            XCTAssertTrue([cache count] == count,@"count %d vs %d",(int)[cache count],(int)count);
        }
        [cache testConsistency];
        
    }
}

- (void)testGetterCase
{
    NTESLRUCache *cache = [[NTESLRUCache alloc] initWithCapacity:3];
    
    [cache setObject:@(0) forKey:@(0)];
    [cache setObject:@(1) forKey:@(1)];
    [cache setObject:@(2) forKey:@(2)];
    [cache setObject:@(3) forKey:@(3)];
    [cache testConsistency];
    XCTAssertNil([cache objectForKey:@(0)]);
    XCTAssertNotNil([cache objectForKey:@(1)]);
    [cache testConsistency];
    [cache setObject:@(4) forKey:@(4)];
    [cache testConsistency];
    XCTAssertNil([cache objectForKey:@(2)]);
    XCTAssertNotNil([cache objectForKey:@(3)]);
    [cache testConsistency];
    [cache setObject:@(5) forKey:@(5)];
    [cache setObject:@(6) forKey:@(6)];
    [cache testConsistency];
    XCTAssertNotNil([cache objectForKey:@(3)]);
    XCTAssertNil([cache objectForKey:@(2)]);
    XCTAssertNil([cache objectForKey:@(4)]);
    [cache testConsistency];
}

- (void)testRemoveCase
{
    NTESLRUCache *cache = [[NTESLRUCache alloc] initWithCapacity:3];
    
    [cache setObject:@(0) forKey:@(0)];
    [cache setObject:@(1) forKey:@(1)];
    [cache setObject:@(2) forKey:@(2)];
    [cache setObject:@(3) forKey:@(3)];
    [cache testConsistency];
    [cache removeObjectForKey:@(1)];
    [cache testConsistency];
    XCTAssertNil([cache objectForKey:@(1)]);
    [cache testConsistency];
    XCTAssertTrue([cache count] == 2);
    [cache testConsistency];
    [cache setObject:@(4) forKey:@(4)];
    [cache setObject:@(5) forKey:@(5)];
    [cache removeObjectForKey:@(4)];
    [cache testConsistency];
    XCTAssertNil([cache objectForKey:@(4)]);
    [cache testConsistency];
    XCTAssertTrue([cache count] == 2);
    [cache testConsistency];
    [cache setObject:@(6) forKey:@(6)];
    [cache testConsistency];
    [cache removeObjectForKey:@(6)];
    [cache testConsistency];
    XCTAssertNil([cache objectForKey:@(6)]);
    
    
}

@end
