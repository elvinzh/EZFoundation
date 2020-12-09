//
//  NTESFeedMocker.h
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTESFeed.h"


@interface NTESFeedMocker : NSObject
+ (instancetype)shared;
- (NSArray *)mockFeeds:(NSInteger)count;
@end
