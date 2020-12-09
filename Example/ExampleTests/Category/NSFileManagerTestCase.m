//
//  NSFileManagerTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/12/20.
//  Copyright © 2018 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>



@interface NSFileManagerTestCase : XCTestCase

@end

@implementation NSFileManagerTestCase

- (void)setUp {
}

- (void)tearDown {
    
}

- (NSString *)dirForClean:(BOOL)hasSubDir
{
    void (^createFileBlock)(NSString *filepath) = ^(NSString *filepath){
        NSString *content = @"NTESFoundation";
        NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:filepath atomically:YES];
    };
    
    void (^createDirBlock)(NSString *filepath) = ^(NSString *filepath){
        [[NSFileManager defaultManager] createDirectoryAtPath:filepath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    };

    NSString *dir = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSUUID UUID].UUIDString];
    createDirBlock(dir);
    
    if (hasSubDir)
    {
        for (NSInteger i = 0; i < 20; i++)
        {
            BOOL createDir = arc4random() % 3 == 0;
            NSString *filename = [NSString stringWithFormat:@"lv1_%@_%d",createDir ? @"dir" : @"file",(int)i];
            NSString *path = [dir stringByAppendingPathComponent:filename];
            if (createDir)
            {
                createDirBlock(path);
                for (NSInteger j = 0; j < 10; j++)
                {
                    NSString *subFilename =  [NSString stringWithFormat:@"lv2_file_%d",(int)j];
                    NSString *filepath = [path stringByAppendingPathComponent:subFilename];
                    createFileBlock(filepath);
                }
            }
            else
            {
                createFileBlock(path);
            }
        }
    }
    
    
    return dir;
    
}

- (void)testFileAttributes
{
    NSString *filename = [NSString stringWithFormat:@"%@.txt",[NSUUID UUID].UUIDString];
    NSString *content = @"NTESFoundation";
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    [data writeToFile:path
           atomically:YES];
    
    unsigned long long dataSize = (unsigned long long)[data length];
    unsigned long long fileSize = [[NSFileManager defaultManager] ntes_fileSize:path];
    XCTAssertTrue(dataSize == fileSize);
    
    NSString *dataMD5 = [data ntes_md5];
    NSString *fileMD5 = [[NSFileManager defaultManager] ntes_fileMD5:path];
    XCTAssertTrue([dataMD5 isEqualToString:fileMD5]);
}

- (void)testFileRemoveRecursive
{
    //有子目录/文件
    {
        NSString *dir = [self dirForClean:YES];
        XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:dir]);
        XCTAssertTrue([[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil] count] > 0);
        [[NSFileManager defaultManager] ntes_removeItemsAtPathRecursively:dir];
        XCTAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:dir]);
    }
    
    //空目录
    {
        NSString *dir = [self dirForClean:NO];
        XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:dir]);
        XCTAssertTrue([[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil] count] == 0);
        [[NSFileManager defaultManager] ntes_removeItemsAtPathRecursively:dir];
        XCTAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:dir]);
    }
    
    //文件
    {
        NSString *filename = [NSString stringWithFormat:@"%@.txt",[NSUUID UUID].UUIDString];
        NSString *content = @"NTESFoundation";
        NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
        [data writeToFile:path
               atomically:YES];
        
        XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:path]);
        [[NSFileManager defaultManager] ntes_removeItemsAtPathRecursively:path];
        XCTAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:path]);
    }
    
}


@end
