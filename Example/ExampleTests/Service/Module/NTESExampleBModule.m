//
//  NTESExampleBModule.m
//  Example
//
//  Created by amao on 2019/1/28.
//  Copyright © 2019 amao. All rights reserved.
//

#import "NTESExampleBModule.h"

@interface NTESExampleBService : NSObject<NTESExampleBDataService>

@end

@implementation NTESExampleBService

@end

@implementation NTESExampleBModule

NTESModuleLoad

- (NSArray<NTESServicePair *> *)userDataServices
{
    NSMutableArray *services = [NSMutableArray array];
    {
        NTESServicePair *pair = [NTESServicePair new];
        pair.protocol = @protocol(NTESExampleBDataService);
        pair.implClass = NTESExampleBService.class;
        [services addObject:pair];
    }
    return services;
}

@end
