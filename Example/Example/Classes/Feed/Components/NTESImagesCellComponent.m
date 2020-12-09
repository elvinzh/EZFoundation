//
//  NTESImagesCellComponent.m
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESImagesCellComponent.h"
#import <YYKit/YYKit.h>


#define NTESImageViewMargin  (15)
#define NTESImageSize        (100)


@interface NTESImagesCell : UITableViewCell
@property (nonatomic,strong)    NSArray *imageViews;
@end

@implementation NTESImagesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *imageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 9; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NTESImageViewMargin +  (i / 3) * (NTESImageSize + NTESImageViewMargin) , NTESImageSize, NTESImageSize)];
        imageView.hidden = YES;
        [imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    self.imageViews = imageViews;
}


+ (CGFloat)heightByFeed:(NTESFeed *)feed
{
    NSInteger count = feed.images.count;
    count = count > 9 ? 9 : count;
    return NTESImageViewMargin + (count / 3 + 1 ) * (NTESImageSize + NTESImageViewMargin);
}

- (void)refresh:(NTESFeed *)feed
{
    NSArray *urls = feed.images;
    for (NSInteger i = 0; i < [urls count] && i < [self.imageViews count]; i++)
    {
        UIImageView *imageView = self.imageViews[i];
        NSURL *url = [NSURL URLWithString:urls[i]];
        [imageView setImageURL:url];
        [imageView setHidden:NO];
    }
    
    for (NSInteger i = [urls count]; i < [self.imageViews count]; i++)
    {
        [self.imageViews[i] setHidden:YES];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i = 0; i < [self.imageViews count]; i++)
    {
        UIImageView *imageView = self.imageViews[i];
        CGFloat hm = (self.frame.size.width - 3 * NTESImageSize) / 4;
        CGRect frame = imageView.frame;
        frame.origin.x = (i % 3 ) * (hm + NTESImageSize) + hm;
        imageView.frame = frame;
    }
}

@end




@implementation NTESImagesCellComponent
- (Class)cellClass
{
    return [NTESImagesCell class];
}

- (CGFloat)height
{
    return [NTESImagesCell heightByFeed:self.feed];
}

- (void)configure:(NTESImagesCell *)cell
{
    [super configure:cell];
    [cell refresh:self.feed];
}
@end
