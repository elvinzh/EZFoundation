//
//  NTESNavigationBarCategory.m
//  Pods
//
//  Created by zmc on 2018/6/8.
//

#import "NTESNavigationBarCategory.h"
#import <objc/runtime.h>
#import "NTESMacro.h"
#import "NSObject+NTESFoundation.h"
#import "UIImage+NTESFoundation.h"

#define NTESNavigationBarLayoutKey      (@"ntes_iOS11_layout")
#define NTESNavigationBarHeight         (44.0f)
#define NTESStatusBarHeight             (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define NTESPortraitTopHeight           (NTESNavigationBarHeight + NTESStatusBarHeight)

@implementation UINavigationBar (NTESFoundation)

+ (void)load
{
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self ntes_swizzleInstanceSelector:@selector(layoutSubviews) withSelector:@selector(ntes_layoutSubviews)];
        });
    }
}


-(void)ntes_layoutSubviews
{
    [self ntes_layoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        NSString * backgroundViewClass = @"_UIBarBackground";
        for (UIView * subView in self.subviews){
            if ([subView isKindOfClass:NSClassFromString(backgroundViewClass)]) {
                if ((subView.frame.size.height < NTESPortraitTopHeight) && subView.frame.origin.y == 0) {
                    CGRect rect = subView.frame;
                    rect.size.height = NTESPortraitTopHeight;
                    subView.frame = rect;
                    break;
                }
            }
        }
    }
}
@end



static char NTESCustomNavBarKey;
@implementation UIViewController (NTESFoundation)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ntes_swizzleInstanceSelector:@selector(viewDidLoad) withSelector:@selector(ntes_viewDidLoad)];
        [self ntes_swizzleInstanceSelector:@selector(viewWillAppear:) withSelector:@selector(ntes_viewWillAppear:)];
        [self ntes_swizzleInstanceSelector:@selector(viewDidAppear:) withSelector:@selector(ntes_viewDidAppear:)];
        [self ntes_swizzleInstanceSelector:@selector(viewWillLayoutSubviews) withSelector:@selector(ntes_viewWillLayoutSubviews)];
    });
}

+ (CGFloat)ntes_viewStartOffsetY
{
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) ? 52.f : (44.f + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame));
}

- (void)ntes_viewDidLoad {
    self.navigationController.navigationBar.translucent = YES;
    [self ntes_viewDidLoad];
}

- (BOOL)ntes_shouldIgnoreNavigationConfig
{
    if ([self.navigationController.viewControllers indexOfObjectIdenticalTo: self] == NSNotFound) return YES;
    return  [NSStringFromClass(self.class) hasPrefix:@"UI"] ||
            [self isKindOfClass:[UINavigationController class]] ||
            [self isKindOfClass:[UITabBarController class]] ||
            [self isKindOfClass:NSClassFromString(@"CKSMSComposeController")] ||
            [self isKindOfClass:NSClassFromString(@"MFMessageComposeViewController")];
}

- (void)ntes_viewWillAppear:(BOOL)animated {
    if(![self ntes_shouldIgnoreNavigationConfig]){
        [self.navigationController.navigationBar setHidden:NO];
        [self.navigationController setNavigationBarHidden:![self ntes_shouldShowNavigationBar] animated:animated];
        
        if ([self ntes_shouldShowNavigationBar]) {
            [self ntes_setNavigationBarStyle];
            
            //坑爹！必须要设置navigationBar.barStyle才会更新statusBarStyle
            if ([self preferredStatusBarStyle] == UIStatusBarStyleLightContent)
                self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
            else self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        }
        
        UIViewController * vc = [[self transitionCoordinator] viewControllerForKey:UITransitionContextFromViewControllerKey];
        if (vc != nil) {
            NTESNavigationBarConfig * fromVCNavBarConfig = [vc ntes_navigationBarConfig];
            UIColor * fromColor= fromVCNavBarConfig.backgroundColor;
            UIColor * toColor = [self ntes_navigationBarConfig].backgroundColor;
            
            
            if ([self ntes_shouldShowNavigationBar] && [vc ntes_shouldShowNavigationBar]) {
                if ([self ntes_navigationBarConfig].alpha != fromVCNavBarConfig.alpha || !CGColorEqualToColor(fromColor.CGColor, toColor.CGColor)) {
                    [self.navigationController.navigationBar ntes_setAlpha:0];
                    [vc ntes_addCustomNavigationBar];
                    [self ntes_addCustomNavigationBar];
                }
            }
        }
    }
    [self ntes_viewWillAppear:animated];
}

- (void)ntes_viewDidAppear:(BOOL)animated {
    if(![self ntes_shouldIgnoreNavigationConfig]){
        if ([self ntes_shouldShowNavigationBar]) {
            [self.navigationController.navigationBar ntes_setAlpha:[self ntes_navigationBarConfig].alpha];
            UIViewController * vc = [[self transitionCoordinator] viewControllerForKey:UITransitionContextFromViewControllerKey];
            if (vc) [vc ntes_removeCustomNavigationBar];
            [self ntes_removeCustomNavigationBar];
        }
    }
    [self ntes_viewDidAppear:animated];
}


- (void)ntes_viewWillLayoutSubviews {
    if(![self ntes_shouldIgnoreNavigationConfig]){
        if ([self ntes_customNavigationBar]){
            UINavigationBar * customNavBar = [self ntes_customNavigationBar];
            CGPoint point = [self.view.window convertPoint:CGPointZero toView:self.view];
            customNavBar.frame = CGRectMake(0, point.y, [UIScreen mainScreen].bounds.size.width, [UIViewController ntes_viewStartOffsetY]);
            [customNavBar ntes_hideBottomLine:(([self ntes_navigationBarConfig].alpha < 1) || ![self ntes_shouldShowBarBottomLine])];
            [customNavBar ntes_setBottomImage:[self ntes_navigationBarBottomLineImage]];
            [self.view bringSubviewToFront:customNavBar];
        }
        
        BOOL isTransparentBar = [self.navigationController.navigationBar ntes_getAlpha] < 0.01;
        [self.navigationController.navigationBar ntes_hideBottomLine:isTransparentBar || ![self ntes_shouldShowBarBottomLine]];
    }
    [self ntes_viewWillLayoutSubviews];
}



- (NTESNavigationBarConfig *)ntes_navigationBarConfig
{
    if ([self respondsToSelector:@selector(ntes_viewControllerNavigationBarConfig)]) {
        NTESNavigationBarConfig * config = [self ntes_viewControllerNavigationBarConfig];
        if ([config isKindOfClass:[NTESNavigationBarConfig class]]) return config;
    }
    return [NTESNavigationBarConfig defaultConfig];
}

- (BOOL)ntes_shouldShowBarBottomLine
{
    if ([self respondsToSelector:@selector(ntes_viewControllerShouldShowBarBottomLine)]) {
        return [self ntes_viewControllerShouldShowBarBottomLine];
    }
    return YES;
}

- (BOOL)ntes_shouldShowNavigationBar
{
    if ([self respondsToSelector:@selector(ntes_viewControllerShouldShowNavigationBar)]) {
        return [self ntes_viewControllerShouldShowNavigationBar];
    }
    return YES;
}



- (UIImage *)ntes_navigationBarBottomLineImage
{
    if ([self respondsToSelector:@selector(ntes_viewControllerNavigationBarBottomLineImage)]) {
        UIImage * image = [self ntes_viewControllerNavigationBarBottomLineImage];
        if ([image isKindOfClass:[UIImage class]]) return image;
    }
    return [UIImage ntes_imageWithColor:NTESRGB(0xcccccc)];
}

- (BOOL)ntes_extendedLayoutNone
{
    if ([self respondsToSelector:@selector(ntes_viewControllerExtendedLayoutNone)]) {
        return [self ntes_viewControllerExtendedLayoutNone];
    }
    return NO;
}

- (void)ntes_setNavigationBarStyle
{
    [self.navigationController.navigationBar ntes_applyConfig:[self ntes_navigationBarConfig]];
    BOOL isTransparentBar = [self.navigationController.navigationBar ntes_getAlpha] < 0.01;
    [self.navigationController.navigationBar ntes_hideBottomLine:isTransparentBar || ![self ntes_shouldShowBarBottomLine]];
    [self.navigationController.navigationBar ntes_setBottomImage:[self ntes_navigationBarBottomLineImage]];
}

- (UINavigationBar *)ntes_customNavigationBar
{
    return objc_getAssociatedObject(self, &NTESCustomNavBarKey);
}

- (void)ntes_setCustomNavBar:(UINavigationBar *)customNavBar
{
    if (customNavBar && [customNavBar isKindOfClass:[UINavigationBar class]])
        objc_setAssociatedObject(self, &NTESCustomNavBarKey, customNavBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)ntes_addCustomNavigationBar
{
    if ([self ntes_shouldShowNavigationBar] && [self ntes_navigationBarConfig].alpha > 0)  {
        if (![self ntes_customNavigationBar]) {
            [self ntes_setCustomNavBar:[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIViewController ntes_viewStartOffsetY])]];
        }
        UINavigationBar * customNavBar = [self ntes_customNavigationBar];
        [customNavBar ntes_applyConfig:[self ntes_navigationBarConfig]];
        [customNavBar ntes_setAlpha:[self ntes_navigationBarConfig].alpha];
        CGPoint point = [self.view.window convertPoint:CGPointZero toView:self.view];
        customNavBar.frame = CGRectMake(0, point.y, [UIScreen mainScreen].bounds.size.width, [UIViewController ntes_viewStartOffsetY]);
        [customNavBar ntes_hideBottomLine:(([self ntes_navigationBarConfig].alpha < 1) || ![self ntes_shouldShowBarBottomLine])];
        [customNavBar ntes_setBottomImage:[self ntes_navigationBarBottomLineImage]];
        [self.view addSubview:customNavBar];
        
    }
}

- (void)ntes_removeCustomNavigationBar
{
    [[self ntes_customNavigationBar] removeFromSuperview];
}
@end


