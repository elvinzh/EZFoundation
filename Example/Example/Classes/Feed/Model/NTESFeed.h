//
//  NTESFeed.h
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTESFeed : NSObject
@property (nonatomic,copy)      NSString    *name;
@property (nonatomic,copy)      NSString    *info;
@property (nonatomic,copy)      NSString    *avatarURLString;
@property (nonatomic,copy)      NSString    *text;
@property (nonatomic,strong)    NSArray     *images;
@property (nonatomic,assign)    NSInteger   commentCount;
@property (nonatomic,assign)    NSInteger   repostCount;

@end
