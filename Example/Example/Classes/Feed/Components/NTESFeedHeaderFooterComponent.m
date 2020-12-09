//
//  NTESFeedHeaderFooterComponent.m
//  Example
//
//  Created by amao on 2018/6/25.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESFeedHeaderFooterComponent.h"


@interface NTESFeedHeaderFooterComponent ()
@property (nonatomic,copy)  NSString    *text;
@end



@implementation NTESFeedHeaderFooterComponent

+ (NTESFeedHeaderFooterComponent *)component:(NSString *)text
{
    NTESFeedHeaderFooterComponent *instance = [[NTESFeedHeaderFooterComponent alloc] init];
    instance.text = text;
    return instance;
}

- (CGFloat)height
{
    return 20.0;
}

- (void)configure:(UITableViewHeaderFooterView *)view
{
    view.textLabel.text = self.text;
}

- (Class)viewClass
{
    return [UITableViewHeaderFooterView class];
}

@end
