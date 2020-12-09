//
//  NTESKeyValueStoreTestCase.m
//  Example
//
//  Created by amao on 2016/12/20.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESKeyValueStore.h"



@interface NTESKeyValueStoreTestCase : XCTestCase
@end

@implementation NTESKeyValueStoreTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testKeyValueStore
{
    [self storeString:NTESLookUpModeFullCache];
    [self storeString:NTESLookUpModePartialCache];
    
    [self storeNumber:NTESLookUpModeFullCache];
    [self storeNumber:NTESLookUpModePartialCache];
    
    [self serialAndDeserial:NTESLookUpModeFullCache];
    [self serialAndDeserial:NTESLookUpModePartialCache];
    
    [self replace:NTESLookUpModeFullCache];
    [self replace:NTESLookUpModePartialCache];
    
    [self removeOneByReplacing:NTESLookUpModeFullCache];
    [self removeOneByReplacing:NTESLookUpModePartialCache];
    
    [self removeOne:NTESLookUpModeFullCache];
    [self removeOne:NTESLookUpModePartialCache];
    
    [self removeAll:NTESLookUpModeFullCache];
    [self removeAll:NTESLookUpModePartialCache];
    
    [self getAllObjects:NTESLookUpModeFullCache];
    [self getAllObjects:NTESLookUpModePartialCache];
}



- (void)storeString:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSInteger  i = 0; i < 100; i++)
    {
        
        NSString *key = [NSString stringWithFormat:@"key_%ud",arc4random()];
        NSString *value = [NSString stringWithFormat:@"value_%ud",arc4random()];
        dict[key] = value;
    }
    
    NTESKeyValueStore *store = [self storeByPath:path
                                            mode:mode];
    for (NSString *key in dict.allKeys)
    {
        [store setObject:dict[key]
                  forKey:key];
    }
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertTrue([dict[key] isEqualToString:object]);
    }
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertTrue([dict[key] isEqualToString:object]);
    }
}




- (void)storeNumber:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSInteger  i = 0; i < 100; i++)
    {
        
        NSString *key = [NSString stringWithFormat:@"key_%ud",arc4random()];
        NSNumber *value = @(arc4random());
        dict[key] = value;
    }
    
    NTESKeyValueStore *store = [self storeByPath:path mode:mode];
    for (NSString *key in dict.allKeys)
    {
        [store setObject:dict[key]
                  forKey:key];
    }
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertTrue([dict[key] integerValue] == [object integerValue]);
    }
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertTrue([dict[key] integerValue] == [object integerValue]);
    }

}

- (void)serialAndDeserial:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSInteger  i = 0; i < 100; i++)
    {
        
        NSString *key = [NSString stringWithFormat:@"key_%ud",arc4random()];
        NSArray *items = @[@(arc4random()),@(arc4random()),@(arc4random())];
        dict[key] = items;
    }
    
    NTESKeyValueStoreOption *option = [NTESKeyValueStoreOption new];
    option.path = path;
    option.mode = mode;
    option.serializer = [NTESKeyValueStore jsonSerializer];
    option.deserializer = [NTESKeyValueStore jsonDeserializer];
    
    NTESKeyValueStore *store = [[NTESKeyValueStore alloc] initWithOption:option];
    
    for (NSString *key in dict.allKeys)
    {
        [store setObject:dict[key]
                  forKey:key];
    }
    
    for (NSString *key in dict.allKeys)
    {
        NSArray *object = (NSArray *)[store objectForKey:key];
        NSArray *items = dict[key];
        XCTAssertTrue([object count] == [items count]);
        
        for (NSInteger i = 0; i < [items count]; i++)
        {
            NSInteger a = [items[i] integerValue];
            NSInteger b = [object[i] integerValue];
            XCTAssertTrue(a == b);
        }
        
        
    }
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    
    for (NSString *key in dict.allKeys)
    {
        NSArray * object = (NSArray *)[store objectForKey:key];
        NSArray *items = dict[key];
        XCTAssertTrue([object count] == [items count]);
        
        for (NSInteger i = 0; i < [items count]; i++)
        {
            NSInteger a = [items[i] integerValue];
            NSInteger b = [object[i] integerValue];
            XCTAssertTrue(a == b);
        }
    }
}

- (void)replace:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSString *key  = [[NSUUID UUID] UUIDString];
    NSString *value = [[NSUUID UUID] UUIDString];
    NTESKeyValueStore *store = [self storeByPath:path mode:mode];
    
    [store setObject:value
              forKey:key];
    
    id object = [store objectForKey:key];
    XCTAssertTrue([value isEqualToString:object]);
    
    NSString *newValue = [[NSUUID UUID] UUIDString];
    
    [store setObject:newValue
              forKey:key];
    
    id newObject = [store objectForKey:key];
    
    XCTAssertTrue([value isEqualToString:object]);
    XCTAssertTrue([newValue isEqualToString:newObject]);
    XCTAssertFalse([value isEqualToString:newObject]);
    XCTAssertFalse([newValue isEqualToString:object]);
    
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    newObject = [store objectForKey:key];
    
    XCTAssertTrue([value isEqualToString:object]);
    XCTAssertTrue([newValue isEqualToString:newObject]);
    XCTAssertFalse([value isEqualToString:newObject]);
    XCTAssertFalse([newValue isEqualToString:object]);
    
    
}

- (void)removeOneByReplacing:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSString *key  = [[NSUUID UUID] UUIDString];
    NSString *value = [[NSUUID UUID] UUIDString];
    NTESKeyValueStore *store = [self storeByPath:path mode:mode];
    
    [store setObject:value
              forKey:key];
    
    id object = [store objectForKey:key];
    XCTAssertTrue([value isEqualToString:object]);

    [store setObject:nil
              forKey:key];
    
    id newObject = [store objectForKey:key];
    XCTAssertNil(newObject);

    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    newObject = [store objectForKey:key];
    XCTAssertNil(newObject);

}

- (void)removeOne:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSString *key  = [[NSUUID UUID] UUIDString];
    NSString *value = [[NSUUID UUID] UUIDString];
    NTESKeyValueStore *store = [self storeByPath:path mode:mode];
    
    [store setObject:value
              forKey:key];
    
    id object = [store objectForKey:key];
    XCTAssertTrue([value isEqualToString:object]);
    
    [store removeObjectForKey:key];
    
    id newObject = [store objectForKey:key];
    XCTAssertNil(newObject);
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    newObject = [store objectForKey:key];
    XCTAssertNil(newObject);
}


- (void)removeAll:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NTESKeyValueStore *store = [self storeByPath:path mode:mode];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSInteger  i = 0; i < 100; i++)
    {
        
        NSString *key = [NSString stringWithFormat:@"key_%ud",arc4random()];
        NSNumber *value = @(arc4random());
        dict[key] = value;
        [store setObject:value
                  forKey:key];
    }
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertTrue([dict[key] integerValue] == [object integerValue]);
    }
    
    [store removeAllObjects];
    
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertNil(object);
    }
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    for (NSString *key in dict.allKeys)
    {
        id object = [store objectForKey:key];
        XCTAssertNil(object);
    }
}

- (void)getAllObjects:(NTESLookUpMode)mode
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NTESKeyValueStore *store = [self storeByPath:path mode:mode];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSInteger  i = 0; i < 100; i++)
    {
        
        NSString *key = [NSString stringWithFormat:@"key_%ud",arc4random()];
        NSNumber *value = @(arc4random());
        dict[key] = value;
        [store setObject:value
                  forKey:key];
    }
    
    NSDictionary *result = [store allObjects];
    
    XCTAssertTrue([result count] == [dict count]);
    for (NSString *key in dict.allKeys)
    {
        id object = result[key];
        XCTAssertTrue([dict[key] integerValue] == [object integerValue]);
    }
    
    
    //清理内存缓存
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    result = [store allObjects];
    
    XCTAssertTrue([result count] == [dict count]);
    for (NSString *key in dict.allKeys)
    {
        id object = result[key];
        XCTAssertTrue([dict[key] integerValue] == [object integerValue]);
    }
}

- (NTESKeyValueStore *)storeByPath:(NSString *)path
                              mode:(NTESLookUpMode)mode
{
    NTESKeyValueStoreOption *option = [NTESKeyValueStoreOption new];
    option.path = path;
    option.mode = mode;
    return [[NTESKeyValueStore alloc] initWithOption:option];
}


@end
