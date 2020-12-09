//
//  NTESFeedMocker.m
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESFeedMocker.h"


@interface NTESFeedMocker ()
@property (nonatomic,strong)    NSArray *feeds;
@end

@implementation NTESFeedMocker
+ (instancetype)shared
{
    static NTESFeedMocker *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NTESFeedMocker alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self loadFeeds];
    }
    return self;
}

- (NSArray *)mockFeeds:(NSInteger)count
{
    NSMutableArray *feeds = [NSMutableArray array];
    for (NSInteger i = 0; i< count; i++)
    {
        NSInteger index = arc4random() % [self.feeds count];
        [feeds addObject:self.feeds[index]];
    }
    return feeds;
    
}


#pragma mark - misc
- (void)loadFeeds
{
    NSMutableArray *feeds = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weibo_0" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    NSArray *items = dict[@"statuses"];
    for (NSDictionary *item in items)
    {
        NTESFeed *feed = [[NTESFeed alloc] init];
        
        feed.name = item[@"user"][@"screen_name"];
        feed.info = item[@"created_at"];
        feed.avatarURLString = item[@"user"][@"avatar_large"];
        
        feed.text = item[@"text"];
        
        NSMutableArray *images = [NSMutableArray array];
        NSArray *imageIds = item[@"pic_ids"];
        if ([imageIds isKindOfClass:[NSArray class]])
        {
            for (NSString *imageId in imageIds)
            {
                NSString *url = item[@"pic_infos"][imageId][@"thumbnail"][@"url"];
                if ([url length])
                {
                    [images addObject:url];
                }
            }
        }
        if ([images count])
        {
            feed.images = images;
        }
        
        feed.repostCount = [item[@"reposts_count"] integerValue];
        feed.commentCount= [item[@"comments_count"] integerValue];
        [feeds addObject:feed];
    }
    
    

    _feeds = feeds;;
}
@end
