//
//  NTESListDiffCellComponent.m
//  Example
//
//  Created by amao on 2018/7/3.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESListDiffCellComponent.h"

@implementation NTESListDiffCellComponent

- (CGFloat)height
{
    
    return 42.0;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = [_number stringValue];
}

- (Class)cellClass
{
    return [UITableViewCell class];
}

- (NSString *)diffableHash
{
    return [_number stringValue];
}
@end
