//
//  NTESNavigationBarCategory.h
//  Pods
//
//  Created by zmc on 2018/6/8.
//

#import <Foundation/Foundation.h>
#import "NTESNavigationBarConfigProtocolHeader.h"


@interface UINavigationBar (NTESFoundation)

@end

@interface UIViewController (NTESFoundation) <NTESNavigationBarConfigProtocol>

@end
