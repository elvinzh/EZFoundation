//
//  NTESUserDefaultsTestCase.m
//  Example
//
//  Created by amao on 2017/3/3.
//  Copyright © 2017年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESFoundation.h"

@protocol NTESUserDefaultsSubclass<NSObject>
@optional
@property (nonatomic,assign)    BOOL                boolValue;
@property (nonatomic,assign)    char                charValue;
@property (nonatomic,assign)    unsigned char       unsignedCharValue;
@property (nonatomic,assign)    short               shortValue;
@property (nonatomic,assign)    unsigned short      unsignedShortValue;
@property (nonatomic,assign)    int                 intValue;
@property (nonatomic,assign)    unsigned int        unsignedIntValue;
@property (nonatomic,assign)    int32_t             int32Value;
@property (nonatomic,assign)    uint32_t            uint32Value;
@property (nonatomic,assign)    int64_t             int64Value;
@property (nonatomic,assign)    uint64_t            uint64Value;
@property (nonatomic,assign)    NSInteger           integerValue;
@property (nonatomic,assign)    NSUInteger          uintegerValue;
@property (nonatomic,assign)    long                longValue;
@property (nonatomic,assign)    unsigned long       unsignedLongValue;
@property (nonatomic,assign)    long long           longlongValue;
@property (nonatomic,assign)    unsigned long long  unsignedLongLongValue;
@property (nonatomic,assign)    float               floatValue;
@property (nonatomic,assign)    CGFloat             cgfloatValue;
@property (nonatomic,assign)    double              doubleValue;
@property (nonatomic,assign)    NSTimeInterval      timeIntervalValue;
@property (nonatomic,strong)    NSDate              *dateValue;
@property (nonatomic,copy)      NSString            *stringValue;
@property (nonatomic,copy)      NSData              *dataValue;
@property (nonatomic,copy)      NSArray             *arrayValue;
@property (nonatomic,copy)      NSDictionary        *dictValue;
@property (nonatomic,strong)    NSMutableString            *mutableStringValue;
@property (nonatomic,strong)    NSMutableData              *mutableDataValue;
@property (nonatomic,strong)    NSMutableArray             *mutableArrayValue;
@property (nonatomic,strong)    NSMutableDictionary        *mutableDictionaryValue;
@end


@interface NTESUserDefaultsSubclass : NTESUserDefaults<NTESUserDefaultsSubclass>
@end

@implementation NTESUserDefaultsSubclass
@end

@interface NTESUserDefaultsTestCase : XCTestCase

@end

@implementation NTESUserDefaultsTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNullValue
{
    NSString *filepath = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NTESUserDefaultsSubclass *defaults = [[NTESUserDefaultsSubclass alloc] initWithPath:filepath];
    XCTAssertTrue(defaults.boolValue == NO);
    
    XCTAssertTrue(defaults.charValue == 0);
    
    XCTAssertTrue(defaults.unsignedCharValue == 0);
    
    XCTAssertTrue(defaults.shortValue == 0);
    
    XCTAssertTrue(defaults.unsignedShortValue == 0);
    
    XCTAssertTrue(defaults.intValue == 0);
    
    XCTAssertTrue(defaults.unsignedIntValue == 0);
    
    XCTAssertTrue(defaults.int32Value == 0);
    
    XCTAssertTrue(defaults.uint32Value == 0);
    
    XCTAssertTrue(defaults.int64Value == 0);
    
    XCTAssertTrue(defaults.uint64Value == 0);
    
    XCTAssertTrue(defaults.integerValue == 0);
    
    XCTAssertTrue(defaults.uintegerValue == 0);
    
    XCTAssertTrue(defaults.longValue == 0);
    
    XCTAssertTrue(defaults.unsignedLongValue == 0);
    
    XCTAssertTrue(defaults.longlongValue == 0);
    
    XCTAssertTrue(defaults.unsignedLongLongValue == 0);
    
    XCTAssertTrue(fabs(defaults.floatValue - 0) < 0.000001);
    
    XCTAssertTrue(fabs(defaults.cgfloatValue - 0) < 0.000001);
    
    XCTAssertTrue(fabs(defaults.doubleValue - 0) < 0.000001);
    
    XCTAssertTrue(fabs(defaults.timeIntervalValue - 0) < 0.000001);
    
    XCTAssertTrue(defaults.dateValue == nil);
    
    XCTAssertTrue(defaults.stringValue == nil);
    
    XCTAssertTrue(defaults.dataValue == nil);
    
    XCTAssertTrue(defaults.arrayValue == nil);
    
    XCTAssertTrue(defaults.dictValue == nil);
    
    XCTAssertTrue(defaults.mutableStringValue == nil);
    
    XCTAssertTrue(defaults.mutableDataValue == nil);
    
    XCTAssertTrue(defaults.mutableArrayValue == nil);
    
    XCTAssertTrue(defaults.mutableDictionaryValue == nil);
    
}


- (void)testSetterAndGetter
{
    NSString *filepath = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NTESUserDefaultsSubclass *defaults = [[NTESUserDefaultsSubclass alloc] initWithPath:filepath];
    defaults.boolValue = YES;
    XCTAssertTrue(defaults.boolValue == YES);
    
    defaults.charValue = 2;
    XCTAssertTrue(defaults.charValue == 2);
    
    defaults.unsignedCharValue = 3;
    XCTAssertTrue(defaults.unsignedCharValue == 3);
    
    defaults.shortValue = 4;
    XCTAssertTrue(defaults.shortValue == 4);
    
    defaults.unsignedShortValue = 5;
    XCTAssertTrue(defaults.unsignedShortValue == 5);
    
    defaults.intValue = 6;
    XCTAssertTrue(defaults.intValue == 6);
    
    defaults.unsignedIntValue = 7;
    XCTAssertTrue(defaults.unsignedIntValue == 7);
    
    defaults.int32Value = 8;
    XCTAssertTrue(defaults.int32Value == 8);
    
    defaults.uint32Value = 9;
    XCTAssertTrue(defaults.uint32Value == 9);
    
    
    defaults.int64Value = 10;
    XCTAssertTrue(defaults.int64Value == 10);
    
    defaults.uint64Value = 11;
    XCTAssertTrue(defaults.uint64Value == 11);
    
    defaults.integerValue = 12;
    XCTAssertTrue(defaults.integerValue == 12);
    
    defaults.uintegerValue = 13;
    XCTAssertTrue(defaults.uintegerValue == 13);
    
    defaults.longValue = 14;
    XCTAssertTrue(defaults.longValue == 14);
    
    defaults.unsignedLongValue = 15;
    XCTAssertTrue(defaults.unsignedLongValue == 15);
    
    defaults.longlongValue = 16;
    XCTAssertTrue(defaults.longlongValue == 16);
    
    defaults.unsignedLongLongValue = 17;
    XCTAssertTrue(defaults.unsignedLongLongValue == 17);
    
    defaults.floatValue = 18.0;
    XCTAssertTrue(fabs(defaults.floatValue - 18) < 0.000001);
    
    defaults.cgfloatValue = 19.0;
    XCTAssertTrue(fabs(defaults.cgfloatValue - 19) < 0.000001);

    defaults.doubleValue = 20.0;
    XCTAssertTrue(fabs(defaults.doubleValue - 20) < 0.000001);
    
    defaults.timeIntervalValue = 21.0;
    XCTAssertTrue(fabs(defaults.timeIntervalValue - 21) < 0.000001);
    
    NSDate *date = [NSDate date];
    defaults.dateValue = date;
    XCTAssertTrue([defaults.dateValue isEqualToDate:date]);
    
    defaults.stringValue = @"22";
    XCTAssertTrue([defaults.stringValue isEqualToString:@"22"]);
    
    NSData *data = [@"23" dataUsingEncoding:NSUTF8StringEncoding];
    defaults.dataValue = data;
    XCTAssertTrue([defaults.dataValue isEqualToData:data]);
    
    NSArray *array = @[@"24",@"25",@"26"];
    defaults.arrayValue = array;
    XCTAssertTrue([defaults.arrayValue isEqualToArray:array]);
    
    NSDictionary *dict = @{@"27" : @(28),
                           @(29) : @"30",};
    defaults.dictValue = dict;
    XCTAssertTrue([defaults.dictValue isEqualToDictionary:dict]);
    

}

- (void)testSaveAndRead
{
    NSString *filepath = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSDate *date = [NSDate date];
    
    NSString *string = @"hellowzzzzz";
    NSData *data = [@"testSaveAndRead" dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = @[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3"];
    NSDictionary *dict = @{@"1" : @(2),
                           @(3) : @"4",};

    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    NSMutableData *mutableData = [NSMutableData dataWithData:data];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    
    
    //save
    {
        NTESUserDefaultsSubclass *defaults = [[NTESUserDefaultsSubclass alloc] initWithPath:filepath];
        defaults.boolValue = YES;
        
        defaults.charValue = 2;
        
        defaults.unsignedCharValue = 3;
        
        defaults.shortValue = 4;
        
        defaults.unsignedShortValue = 5;
        
        defaults.intValue = 6;
        
        defaults.unsignedIntValue = 7;
        
        defaults.int32Value = 8;
        
        defaults.uint32Value = 9;
        
        defaults.int64Value = 10;
        
        defaults.uint64Value = 11;
        
        defaults.integerValue = 12;
        
        defaults.uintegerValue = 13;
        
        defaults.longValue = 14;
        
        defaults.unsignedLongValue = 15;
        
        defaults.longlongValue = 16;
        
        defaults.unsignedLongLongValue = 17;
        
        defaults.floatValue = 18.0;
        
        defaults.cgfloatValue = 19.0;
        
        defaults.doubleValue = 20.0;
        
        defaults.timeIntervalValue = 21.0;
        
        defaults.dateValue = date;
        
        defaults.stringValue = string;
        
        defaults.dataValue = data;
        
        defaults.arrayValue = array;
        
        defaults.dictValue = dict;
        
        defaults.mutableStringValue = mutableString;
        
        defaults.mutableDataValue = mutableData;
        
        defaults.mutableArrayValue = mutableArray;
        
        defaults.mutableDictionaryValue = mutableDictionary;
    }
    
    sleep(2);
    
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:filepath]);
    
    //read
    {
        NTESUserDefaultsSubclass *defaults = [[NTESUserDefaultsSubclass alloc] initWithPath:filepath];

        XCTAssertTrue(defaults.boolValue == YES);
        
        XCTAssertTrue(defaults.charValue == 2);
        
        XCTAssertTrue(defaults.unsignedCharValue == 3);
        
        XCTAssertTrue(defaults.shortValue == 4);
        
        XCTAssertTrue(defaults.unsignedShortValue == 5);
        
        XCTAssertTrue(defaults.intValue == 6);
        
        XCTAssertTrue(defaults.unsignedIntValue == 7);
        
        XCTAssertTrue(defaults.int32Value == 8);
        
        XCTAssertTrue(defaults.uint32Value == 9);
        
        XCTAssertTrue(defaults.int64Value == 10);
        
        XCTAssertTrue(defaults.uint64Value == 11);
        
        XCTAssertTrue(defaults.integerValue == 12);
        
        XCTAssertTrue(defaults.uintegerValue == 13);
        
        XCTAssertTrue(defaults.longValue == 14);
        
        XCTAssertTrue(defaults.unsignedLongValue == 15);
        
        XCTAssertTrue(defaults.longlongValue == 16);
        
        XCTAssertTrue(defaults.unsignedLongLongValue == 17);
        
        XCTAssertTrue(fabs(defaults.floatValue - 18) < 0.000001);
        
        XCTAssertTrue(fabs(defaults.cgfloatValue - 19) < 0.000001);
        
        XCTAssertTrue(fabs(defaults.doubleValue - 20) < 0.000001);
        
        XCTAssertTrue(fabs(defaults.timeIntervalValue - 21) < 0.000001);
        
        XCTAssertTrue([defaults.dateValue isEqualToDate:date]);
        
        XCTAssertTrue([defaults.stringValue isEqualToString:string]);
        
        XCTAssertTrue([defaults.dataValue isEqualToData:data]);
        
        XCTAssertTrue([defaults.arrayValue isEqualToArray:array]);
        
        XCTAssertTrue([defaults.dictValue isEqualToDictionary:dict]);
        
        XCTAssertTrue([defaults.mutableStringValue isEqualToString:mutableString]);
        
        XCTAssertTrue([defaults.mutableDataValue isEqualToData:mutableData]);
        
        XCTAssertTrue([defaults.mutableArrayValue isEqualToArray:mutableArray]);
        
        XCTAssertTrue([defaults.mutableDictionaryValue isEqualToDictionary:mutableDictionary]);
        

    }
}



- (void)testDefaultValues
{
    NSString *filepath = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NTESUserDefaultsSubclass *defaults = [[NTESUserDefaultsSubclass alloc] initWithPath:filepath];
    
    [defaults registerDefaults:@{@"boolValue" : @(YES),
                                 @"intValue" : @(100),
                                 @"stringValue"   :  @"hello",
                                 @"invalidValue" : @"22"}];
    
    XCTAssertTrue(defaults.boolValue == YES);
    XCTAssertTrue(defaults.intValue == 100);
    XCTAssertTrue([defaults.stringValue isEqualToString:@"hello"]);
    
    defaults.intValue = 120;
    defaults.stringValue  = @"hi";
    
    XCTAssertTrue(defaults.intValue == 120);
    XCTAssertTrue([defaults.stringValue isEqualToString:@"hi"]);
}




@end
