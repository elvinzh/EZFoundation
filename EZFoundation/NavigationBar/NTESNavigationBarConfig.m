//
//  NTESNavigationBarConfig.m
//  Pods
//
//  Created by 张明川 on 2018/5/7.
//

#import "NTESNavigationBarConfig.h"
#import <objc/runtime.h>



@implementation NTESNavigationBarConfig

static NTESNavigationBarConfig * defaultConfig;

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clear:(BOOL)clear
{
    self = [super init];
    if (self) {
        _backgroundColor = backgroundColor;
        _titleColor = titleColor;
        _titleFont = titleFont;
        _alpha = clear ? 0 : 1;
    }
    return self;
}

+ (NTESNavigationBarConfig *)defaultConfig
{
    if (defaultConfig) {
        return defaultConfig;
    } else {
        return [[NTESNavigationBarConfig alloc] initWithBackgroundColor:[UIColor whiteColor]
                                                             titleColor:[UIColor blackColor]
                                                              titleFont:[UIFont systemFontOfSize:17.f]
                                                                  clear:NO];
    }
}

+ (NTESNavigationBarConfig *)clearConfig
{
    return [[NTESNavigationBarConfig alloc] initWithBackgroundColor:defaultConfig ? defaultConfig.backgroundColor : [UIColor whiteColor]
                                                         titleColor:defaultConfig ? defaultConfig.titleColor : [UIColor blackColor]
                                                          titleFont:defaultConfig ? defaultConfig.titleFont : [UIFont systemFontOfSize:17.f]
                                                              clear:YES];
}
+ (void)registerDefaultConfig:(NTESNavigationBarConfig *)config
{
    defaultConfig = config;
}


@end



#pragma mark - UINavigationBar

static char UINavigationBarConfig;
static char UINavigationBarBottomLine;
static NSInteger kBottomImageViewTag = 100;

@implementation UINavigationBar (NTESNavigationBarConfig)
- (void)ntes_applyConfig:(NTESNavigationBarConfig *)config
{
    id existedConfig =  objc_getAssociatedObject(self, &UINavigationBarConfig);
    if (existedConfig != config || [self ntes_getAlpha] != config.alpha)
    {
        
        //        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self setBarTintColor:config.backgroundColor];
        
        UIFont * font = config.titleFont;
        if (!font) font = [UIFont systemFontOfSize:18.f];
        UIColor * color = config.titleColor ? config.titleColor : [UIColor blackColor];
        NSDictionary * attributes = @{NSFontAttributeName:font,
                                      NSForegroundColorAttributeName:color};
        [self setTitleTextAttributes:attributes];
        [self setTintColor:config.titleColor];
        [self ntes_setAlpha:config.alpha];
        objc_setAssociatedObject(self, &UINavigationBarConfig, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)ntes_setAlpha:(CGFloat)alpha
{
    NSString * backgroundViewClass = @"_UINavigationBarBackground";
    if (@available(iOS 10.0, *)) backgroundViewClass = @"_UIBarBackground";
    
    
    for (UIView * subView in self.subviews)
    {
        if ([subView isKindOfClass:NSClassFromString(backgroundViewClass)]) {
            
            CGFloat currentAlpha = subView.alpha;
            UIView *alphaView;
            
            if (@available(iOS 11.0, *)) {
                NSArray* bgSubViews = subView.subviews;
                if (bgSubViews && bgSubViews.count > 0) {
                    for (UIView* view in bgSubViews) {
                        if ([view isKindOfClass:[UIVisualEffectView class]]) {
                            currentAlpha = view.alpha;
                            alphaView = view;
                            break;
                        }
                    }
                }
            }
            
            if (currentAlpha == alpha) return;
            
            subView.alpha = alpha;
            
            if (@available(iOS 11.0, *)) {
                if (alphaView) {
                    alphaView.alpha = alpha;
                }
            }
            
            
            if(alpha < 0.01) {
                [self ntes_hideBottomLine:YES];
            } else {
                
            }
            
            return;
        }
    }
}

- (CGFloat)ntes_getAlpha
{
    NSString * backgroundViewClass = @"_UINavigationBarBackground";
    if (@available(iOS 10.0, *)) backgroundViewClass = @"_UIBarBackground";
    
    for (UIView * subView in self.subviews)
        if ([subView isKindOfClass:NSClassFromString(backgroundViewClass)]) {
            
            if (@available(iOS 11.0, *)) {
                NSArray* bgSubViews = subView.subviews;
                if (bgSubViews && bgSubViews.count > 0) {
                    for (UIView* view in bgSubViews) {
                        if ([view isKindOfClass:[UIVisualEffectView class]]) {
                            return view.alpha;
                        }
                    }
                }
            }
            
            return subView.alpha;
        }
    return 0;
}


- (void)ntes_hideBottomLine:(BOOL)hidden
{
    id existedLine = objc_getAssociatedObject(self, &UINavigationBarBottomLine);
    if (![existedLine isKindOfClass:[UIImageView class]] || ![existedLine superview])
    {
        //判断superView是因为在点公众号搜索的时候，navbar会往上隐藏  当再次出现的时候 bar里的subview就是新的了。。
        UIImageView *imageView = [self ntes_bottomLine:self];
        if (imageView)
        {
            existedLine = imageView;
            objc_setAssociatedObject(self, &UINavigationBarBottomLine, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        else
        {
            existedLine = nil;
        }
    }
    // 由于要替换默认底部的横线，所以需要吧横线默认设置为隐藏
    [(UIImageView *)existedLine setHidden:YES];
    UIView *bottomView;
    bottomView = [self viewWithTag:kBottomImageViewTag];
    
    //    bottomView.hidden = hidden;
    bottomView.alpha = hidden?0:1;
}

- (void)ntes_setBottomImage:(UIImage *) image
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kBottomImageViewTag];
    
    if (nil == imageView || ![imageView isKindOfClass:[UIImageView class]])
    {
        UIImageView *bottomImageView = [[UIImageView alloc] initWithImage:image];
        bottomImageView.tag          = kBottomImageViewTag;
        bottomImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        bottomImageView.frame        = CGRectMake(0, self.frame.size.height, [UIScreen mainScreen].bounds.size.width, 0.5);
        [self addSubview:bottomImageView];
        
    }
    
    [imageView setImage:image];
}

- (UIImageView *)ntes_bottomLine:(UIView *)view
{
    if ([view isKindOfClass:[UIImageView class]] &&
        view.bounds.size.height <= 1.0 && view.tag != kBottomImageViewTag)
    {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews)
    {
        UIImageView *imageView = [self ntes_bottomLine:subView];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}

@end
