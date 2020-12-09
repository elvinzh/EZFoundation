//
//  NTESCommentCellComponent.m
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESCommentCellComponent.h"

@implementation NTESCommentCellComponent
- (Class)cellClass
{
    return [UITableViewCell class];
}

- (CGFloat)height
{
    return 20.0;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = [NSString stringWithFormat:@"评论 %d 转发 %d",(int)self.feed.commentCount,(int)self.feed.repostCount];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
}
@end
