//
//  NTESItemComponent.m
//  Example
//
//  Created by amao on 2017/5/27.
//  Copyright © 2017年 amao. All rights reserved.
//

#import "NTESItemComponent.h"

@interface NTESItemComponent ()

@end

@implementation NTESItemComponent

+ (instancetype)component:(NSString *)title
                   vcName:(NSString *)vcName
{
    NTESItemComponent *instance = [[NTESItemComponent alloc] init];
    instance.title              = title;
    instance.vcName             = vcName;
    return instance;
}

- (CGFloat)height
{
    return 42;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = self.title;
}

- (Class)cellClass
{
    return [UITableViewCell class];
}
@end
