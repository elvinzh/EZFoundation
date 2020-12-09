//
//  NTESContentCellComponent.m
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESContentCellComponent.h"


@implementation NTESContentCellComponent
- (Class)cellClass
{
    return [UITableViewCell class];
}

- (CGFloat)height
{
    
    CGFloat width = self.tableView.bounds.size.width;
    if (width == 0)
    {
        width = [[UIScreen mainScreen] bounds].size.width;
    }
    return [self.feed.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0] }
                                        context:nil].size.height + 20;
}

- (void)configure:(UITableViewCell *)cell
{
    [super configure:cell];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.feed.text;
}

@end
