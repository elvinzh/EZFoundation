//
//  NTESUtility.m
//  Example
//
//  Created by amao on 2016/12/19.
//  Copyright © 2016年 amao. All rights reserved.
//

#import "NTESUtility.h"
#import "NSObject+NTESFoundation.h"

@interface NSBundle (NTESUtility)
@end

@implementation NSBundle (NTESUtility)
+ (NSBundle *)xct_mainBundle
{
    NSBundle *bundle =  [NSBundle bundleForClass:[NTESUtility class]];
    return bundle;
}
@end

@implementation NTESUtility
+ (void)swizzleMainBundle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSBundle ntes_swizzleClassSelector:@selector(mainBundle)
                               withSelector:@selector(xct_mainBundle)];
    });
}
@end
