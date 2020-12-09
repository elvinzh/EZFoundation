//
//  NTESTextTableViewCellComponent.m
//  Example
//
//  Created by amao on 2017/5/18.
//  Copyright © 2017年 amao. All rights reserved.
//

#import "NTESTextTableViewCellComponent.h"



@interface NTESTextTableViewCellComponent ()
@property (nonatomic,copy)  NSString    *text;
@end

@implementation NTESTextTableViewCellComponent
+ (instancetype)component:(NSString *)text
{
    NTESTextTableViewCellComponent *instance = [[NTESTextTableViewCellComponent alloc] init];
    instance.text = text;
    return instance;
}

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


#pragma mark - misc
- (BOOL)canEditComponent
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)editActions
{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [self remove];
                                                                          }];
    return @[deleteAction];
}

@end
