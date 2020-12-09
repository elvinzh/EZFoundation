//
//  NTESDownloaderTestCase.m
//  Example
//
//  Created by amao on 2016/12/26.
//  Copyright © 2016年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESDownloader.h"
#import "NTESUtility.h"
#import "NSFileManager+NTESFoundation.h"

@interface NTESDownloaderTestCase : XCTestCase
@property (nonatomic,strong)    NTESDownloader *downloader;
@end

@implementation NTESDownloaderTestCase

- (void)setUp {
    [super setUp];
    self.downloader = [[NTESDownloader alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDownloadSingleFile
{
    NSString *url = @"https://www.baidu.com/img/bd_logo1.png";
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    
    [self.downloader download:url
                     filepath:path
                     progress:^(float progress) {
                         XCTAssertTrue(progress > 0,@"progress is %f",progress);
                         XCTAssertTrue(progress <= 1,@"progress is %f",progress);
                     } completion:^(NSError *error) {
                         XCTAssertNil(error);
                         NTES_TEST_NOTIFY
                     }];
    
    NTES_TEST_WAIT
    
    NSString *md5 = [[NSFileManager defaultManager] ntes_fileMD5:path];
    XCTAssertTrue([md5 isEqualToString:@"b15c113aeddbeb606d938010b88cf8e6"],@"md5 is %@",md5);
}

- (void)testDownloadSameFileTwice
{
    NSString *url = @"https://raw.githubusercontent.com/netease-im/NIM_Resources/master/iOS/Images/nimkit_6.gif";
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    __block NSInteger count = 0;
    
    [self.downloader download:url
                     filepath:path
                     progress:^(float progress) {
                         XCTAssertTrue(progress > 0,@"progress is %f",progress);
                         XCTAssertTrue(progress <= 1,@"progress is %f",progress);
                     } completion:^(NSError *error) {
                         XCTAssertNil(error);
                         count++;
                         if (count == 2)
                         {
                             NTES_TEST_NOTIFY
                         }
                     }];
    
    
    [self.downloader download:url
                     filepath:path
                     progress:^(float progress) {
                         XCTAssertTrue(progress > 0,@"progress is %f",progress);
                         XCTAssertTrue(progress <= 1,@"progress is %f",progress);
                     } completion:^(NSError *error) {
                         XCTAssertNil(error);
                         count++;
                         if (count == 2)
                         {
                             NTES_TEST_NOTIFY
                         }
                     }];
    
    NTES_TEST_WAIT
    
    NSString *md5 = [[NSFileManager defaultManager] ntes_fileMD5:path];
    XCTAssertTrue([md5 isEqualToString:@"373f814f187dab79fbb8aca55330c129"],@"md5 is %@",md5);
}
@end
