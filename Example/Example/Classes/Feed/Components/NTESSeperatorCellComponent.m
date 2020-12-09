//
//  NTESSeperatorCellComponent.m
//  Example
//
//  Created by amao on 2018/6/19.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESSeperatorCellComponent.h"
#import "NTESFoundation.h"



@implementation NTESSeperatorCellComponent
- (Class)cellClass
{
    return [UITableViewCell class];
}

- (CGFloat)height
{
    return 20;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.backgroundColor = NTESRGB(0xF0F0F0);
}
@end
