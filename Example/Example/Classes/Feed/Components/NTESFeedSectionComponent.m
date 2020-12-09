//
//  NTESFeedSectionComponent.m
//  Example
//
//  Created by amao on 2018/8/28.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESFeedSectionComponent.h"
#import "NTESAvatarTapEvent.h"
#import "NTESFoundation.h"

@implementation NTESFeedSectionComponent

- (BOOL)handleEvent:(NTESTableViewComponentEvent *)event
{
    //打印各个数据
    NSLog(@"get event %@ cell %@ view %@ section %@",event,
          event.cellComponentForEvent,event.viewComponentForEvent,event.sectionComponentForEvent);
    
    if ([event isKindOfClass:[NTESAvatarTapEvent class]])
    {
        NTESAvatarTapEvent *tapEvent = (NTESAvatarTapEvent *)[event ntes_asObject:[NTESAvatarTapEvent class]];
        NSLog(@"url %@",tapEvent.url);
    }
    
    return YES;
}

@end
