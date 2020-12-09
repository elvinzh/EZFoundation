//
//  NTESHttpTestCase.m
//  ExampleTests
//
//  Created by amao on 2017/12/6.
//  Copyright © 2017年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESFoundation.h"
#import "NTESUtility.h"

@interface NTESHeaderRequest : NSObject<NTESHttpRequest>
@end

@implementation NTESHeaderRequest
- (NSString *)path
{
    return @"headers";
}
- (NSDictionary *)headers
{
    return @{@"Customkey" : @"CustomValue"};
}
- (NTESResponseSerializerType)responseSerializerType
{
    return NTESResponseSerializerTypeJSON;
}
@end





@interface NTESPostJSONRequest : NSObject<NTESHttpRequest>
@end

@implementation NTESPostJSONRequest
- (NSString *)path
{
    return @"post";
}

- (NTESHttpMethod)method
{
    return NTESHttpMethodPost;
}

- (id)parameters
{
    return @{@"Username" : @"amao",
             @"Password" : @"oama"};
}

- (NTESRequestSerializerType)requestSerializerType
{
    return NTESRequestSerializerTypeJSON;
}

- (NTESResponseSerializerType)responseSerializerType
{
    return NTESResponseSerializerTypeJSON;
}

@end





@interface NTESHttpTestCase : XCTestCase
@property (nonatomic,strong)    NTESHttpService *service;
@property (nonatomic,strong)    NTESHttpConfiguration *configuration;
@end

@implementation NTESHttpTestCase

- (void)setUp {
    [super setUp];
    _configuration = [[NTESHttpConfiguration alloc] init];
    _configuration.baseURL = @"https://httpbin.org/";
    _configuration.defaultHeadersGenerator = ^NSDictionary<NSString *,NSString *> *{
        return  @{@"Defaultkey" : @"DefaultValue"};
    };
    _configuration.exceptionHintEnabeld = NO;
    _service = [[NTESHttpService alloc] initWithConfiguration:_configuration];
    [self setContinueAfterFailure:YES];
}

- (void)tearDown {
    [super tearDown];
    _configuration = nil;
    _service = nil;
}

- (void)testHeaders
{
    NTESHeaderRequest *request = [NTESHeaderRequest new];
    [_service request:request
           completion:^(id returnedObject, NSError *error) {
               XCTAssertTrue([returnedObject isKindOfClass:[NSDictionary class]]);
               XCTAssertNil(error);
               if ([returnedObject isKindOfClass:[NSDictionary class]])
               {
                   NSDictionary *json = (NSDictionary *)returnedObject;
                   NSMutableDictionary *headers = [NSMutableDictionary dictionary];
                   [headers addEntriesFromDictionary:[request headers]];
                   [headers addEntriesFromDictionary:self.configuration.defaultHeadersGenerator()];
                   [self dict:json[@"headers"] contains:headers];
               }
               NTES_TEST_NOTIFY
           }];
    NTES_TEST_WAIT
}

- (void)testJSONPost
{
    NTESPostJSONRequest *request = [NTESPostJSONRequest new];
    [_service request:request
           completion:^(id returnedObject, NSError *error) {
               XCTAssertTrue([returnedObject isKindOfClass:[NSDictionary class]]);
               XCTAssertNil(error);
               if ([returnedObject isKindOfClass:[NSDictionary class]])
               {
                   NSDictionary *json = (NSDictionary *)returnedObject;
                   [self dict:json[@"json"] contains:[request parameters]];
               }
               NTES_TEST_NOTIFY
           }];
    NTES_TEST_WAIT
}


#pragma mark - misc
- (void)dict:(NSDictionary *)dict
    contains:(NSDictionary *)subDict
{
    [subDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *value1 = obj;
        NSString *value2 = dict[key];
        XCTAssertTrue([value1 isEqualToString:value2],@"value compare : %@ vs %@",value1,value2);
    }];
}

@end
