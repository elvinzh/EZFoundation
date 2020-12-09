//
//  NTESNavigationBarConfigProtocolHeader.h
//  Pods
//
//  Created by 张明川 on 2018/5/4.
//

#ifndef NTESNavigationBarConfigProtocolHeader_h
#define NTESNavigationBarConfigProtocolHeader_h

#import "NTESNavigationBarConfig.h"

@protocol NTESNavigationBarConfigProtocol <NSObject>

@optional

/**
 * navigatioinBar下的那条线，目前全都用默认就好
 */
- (UIImage *)ntes_viewControllerNavigationBarBottomLineImage;
/**
 * 不实现的话是默认的[NTESNavigationBarConfig defaultConfig]
 */
- (NTESNavigationBarConfig *)ntes_viewControllerNavigationBarConfig;
/**
 * 需要完全隐藏navigationBar（包括返回键、title..）的话实现这个接口返回NO，默认YES
 */
- (BOOL)ntes_viewControllerShouldShowNavigationBar;
/**
 * 需要隐藏navigationBar下的线的话实现这个接口返回NO，默认YES
 */
- (BOOL)ntes_viewControllerShouldShowBarBottomLine;
/**
 * 是否不延展，默认是NO
 */
- (BOOL)ntes_viewControllerExtendedLayoutNone;

///**
// * 返回键点击事件
// */
//- (void)ntes_viewControllerOnBackButtonPressed:(id)sender;
@end


#endif /* NTESNavigationBarConfigProtocolHeader_h */
