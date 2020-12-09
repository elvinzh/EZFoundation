//
//  NTESDiffableTextCellComponent.m
//  Example
//
//  Created by amao on 2018/6/15.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESDiffableTextCellComponent.h"
#import "NTESFoundation.h"

@implementation NTESDiffableTextCellComponent

- (CGFloat)height
{
    CGFloat width = self.tableView.bounds.size.width;
    return [self.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0] }
                                   context:nil].size.height + 20;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.text;
}

- (Class)cellClass
{
    return [UITableViewCell class];
}

- (NSString *)diffableHash
{
    return [NSString stringWithFormat:@"%@_%@",[super diffableHash],_text];
}


- (void)didSelect:(UITableViewCell *)cell
{
    NTESLogDebug(@"begin select");
    BOOL shouldRefreshText = arc4random() % 3 == 0;
    if (shouldRefreshText)
    {
        NTESLogDebug(@"refresh text");
        self.text = [NSString stringWithFormat:@"%@\n%@",self.text,self.text];
    }
    NTESLogDebug(@"begin reload");
    [self reload];
    NTESLogDebug(@"end reload");
    NTESLogDebug(@"end select");
}

@end
