//
//  NTESExampleAModule.m
//  Example
//
//  Created by amao on 2019/1/28.
//  Copyright © 2019 amao. All rights reserved.
//

#import "NTESExampleAModule.h"

@interface NTESExampleAService : NSObject<NTESExampleAService>

@end

@implementation NTESExampleAService

@end

@implementation NTESExampleAModule

NTESModuleLoad

- (NSArray<NTESServicePair *> *)services
{
    NSMutableArray *services = [NSMutableArray array];
    {
        NTESServicePair *pair = [NTESServicePair new];
        pair.protocol = @protocol(NTESExampleAService);
        pair.implClass = NTESExampleAService.class;
        [services addObject:pair];
    }
    return services;
}
@end
