//
//  NTESTcpClientTestCase.m
//  ExampleTests
//
//  Created by amao on 2017/12/14.
//  Copyright © 2017年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESFoundation.h"
#import "NTESUtility.h"

@interface NTESTcpClientHttpTestCase : XCTestCase<NTESTcpClientDelegate>
@property (nonatomic,strong)    NTESTcpClient *httpClient;
@property (nonatomic,strong)    NSMutableData *httpData;
@end

@implementation NTESTcpClientHttpTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHttpRequest
{
    [self runHttpTestCase:YES];
    [self runHttpTestCase:NO];
}


- (void)runHttpTestCase:(BOOL)resolveDNS
{
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org"];
    NTESHost *host = [[NTESHost alloc] initWithURL:url];
    if (resolveDNS)
    {
        [host resolve];
    }
    _httpData = [[NSMutableData alloc] init];
    _httpClient = [[NTESTcpClient alloc] initWithHost:host];
    _httpClient.delegate = self;
    [_httpClient connect];
    
    
    NTES_TEST_WAIT_WITH_KEY(@"http_connect");
    
    CFHTTPMessageRef request = CFHTTPMessageCreateRequest(NULL, CFSTR("GET"), (__bridge CFURLRef)url, kCFHTTPVersion1_1);
    CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Host"), (__bridge CFStringRef)(url.host));
    CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Accept"),CFSTR("*"));
    CFHTTPMessageSetHeaderFieldValue(request, CFSTR("CustomKey"),CFSTR("CustomValue"));
    NSData *message = CFBridgingRelease(CFHTTPMessageCopySerializedMessage(request));
    [_httpClient write:message];
    
    NTES_TEST_WAIT_WITH_KEY(@"http_write");
    NTES_TEST_WAIT_WITH_KEY(@"http_request_finished");
    
    [_httpClient close];
    
    NTES_TEST_WAIT_WITH_KEY(@"http_close");
}

- (void)clientDidConnect:(NTESTcpClient *)client
{
    if (_httpClient == client)
    {
        NTES_TEST_NOTIFY_WITH_KEY(@"http_connect");
    }
}

- (void)client:(NTESTcpClient *)client didConnectFailed:(NSError *)error
{
    
}

- (void)clientDidConnectTimeout:(NTESTcpClient *)client
{
    
}

- (void)client:(NTESTcpClient *)client didReadData:(NSData *)data
{
    if (_httpClient == client)
    {
        [_httpData appendData:data];
        [self parseHttpResponse];
    }
}

- (void)client:(NTESTcpClient *)client didWriteData:(NSUInteger)dataLength
{
    if (_httpClient == client)
    {
        NTES_TEST_NOTIFY_WITH_KEY(@"http_write");
    }
}

- (void)clientDidClose:(NTESTcpClient *)client reason:(NSError *)error
{
    if (_httpClient == client)
    {
        XCTAssertNotNil(error);
        XCTAssertTrue([error code] == NTESTcpClientErrorCloseBySelf);
        NTES_TEST_NOTIFY_WITH_KEY(@"http_close");
        
    }
}

#pragma mark - Parse Http Response
- (void)parseHttpResponse
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSString *content = [[NSString alloc] initWithData:_httpData
                                              encoding:NSUTF8StringEncoding];
    BOOL validHttpCode = [content hasPrefix:@"HTTP/1.1 200 OK"];
    if (validHttpCode)
    {
        NSArray *items = [content componentsSeparatedByString:@"\r\n\r\n"];
        NSArray *headerItems =  [[items firstObject] componentsSeparatedByString:@"\r\n"];
        NSData *body = [[items lastObject] dataUsingEncoding:NSUTF8StringEncoding];
        for (NSString *headers in headerItems)
        {
            NSArray *header = [headers componentsSeparatedByString:@":"];
            NSString *key = [[header firstObject] stringByTrimmingCharactersInSet:set];
            NSString *value = [[header lastObject] stringByTrimmingCharactersInSet:set];
            if ([key caseInsensitiveCompare:@"Content-Length"] == NSOrderedSame)
            {
                NSInteger length = [value integerValue];
                
                if ([body length] == length)
                {
                    NTES_TEST_NOTIFY_WITH_KEY(@"http_request_finished");
                }
            }
        }
        
    }
}

@end
