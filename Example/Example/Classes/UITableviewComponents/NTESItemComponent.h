//
//  NTESItemComponent.h
//  Example
//
//  Created by amao on 2017/5/27.
//  Copyright © 2017年 amao. All rights reserved.
//

#import <NTESFoundation/NTESFoundation.h>


@interface NTESItemComponent : NTESTableViewCellComponent
@property (nonatomic,copy)      NSString    *title;
@property (nonatomic,copy)      NSString    *vcName;
+ (instancetype)component:(NSString *)title
                   vcName:(NSString *)vcName;
@end
