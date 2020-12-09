//
//  NTESAvatarCellComponent.m
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESAvatarCellComponent.h"
#import <YYKit/YYKit.h>
#import "NTESAvatarTapEvent.h"

@interface NTESAvatarCell : UITableViewCell
@property (nonatomic,copy)  NSString *avatarURLString;
@property (nonatomic,weak)  id<NTESTableViewComponentEventDispatcher>   delegate;
@end

@implementation NTESAvatarCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:reuseIdentifier])
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onTap:)];
        [self.imageView setUserInteractionEnabled:YES];
        [self.imageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)onTap:(id)sender
{
    NTESAvatarTapEvent *event = [NTESAvatarTapEvent new];
    event.url = self.avatarURLString;
    [self.delegate dispatchEvent:event];
}

- (void)refresh:(NTESFeed *)feed
{
    self.avatarURLString = feed.avatarURLString;
    NSURL *url = [NSURL URLWithString:feed.avatarURLString];
    [self.imageView setImageWithURL:url placeholder:[UIImage imageNamed:@"user_avatar"]];
    self.textLabel.text = feed.name;
    self.detailTextLabel.text = feed.info;
}

@end


@implementation NTESAvatarCellComponent
- (Class)cellClass
{
    return [NTESAvatarCell class];
}

- (CGFloat)height
{
    return 50;
}

- (void)configure:(NTESAvatarCell *)cell
{
    [super configure:cell];
    cell.delegate = self;
    [cell refresh:self.feed];
    

}

@end
