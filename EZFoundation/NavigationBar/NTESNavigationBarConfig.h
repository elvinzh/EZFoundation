//
//  NTESNavigationBarConfig.h
//  Pods
//
//  Created by 张明川 on 2018/5/7.
//

#import <Foundation/Foundation.h>


@interface NTESNavigationBarConfig : NSObject
@property (nonatomic,strong,readonly)   UIColor *backgroundColor;
@property (nonatomic,strong,readonly)   UIColor *titleColor;
@property (nonatomic,strong,readonly)   UIFont  *titleFont;
@property (nonatomic,assign,readonly)   CGFloat alpha;

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                              titleFont:(UIFont *)titleFont
                                  clear:(BOOL)clear;

+ (NTESNavigationBarConfig *)defaultConfig;
+ (NTESNavigationBarConfig *)clearConfig;
+ (void)registerDefaultConfig:(NTESNavigationBarConfig *)config;

@end

@interface UINavigationBar (NTESNavigationBarConfig)
- (void)ntes_setAlpha:(CGFloat)alpha;
- (CGFloat)ntes_getAlpha;
- (void)ntes_applyConfig:(NTESNavigationBarConfig *)config;
- (void)ntes_hideBottomLine:(BOOL)hidden;
- (void)ntes_setBottomImage:(UIImage *)image;
@end


