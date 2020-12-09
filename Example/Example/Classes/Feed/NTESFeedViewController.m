//
//  NTESFeedViewController.m
//  Example
//
//  Created by amao on 2018/6/14.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESFeedViewController.h"
#import <NTESFoundation/NTESFoundation.h>
#import "NTESFeedMocker.h"
#import "NTESAvatarCellComponent.h"
#import "NTESContentCellComponent.h"
#import "NTESImagesCellComponent.h"
#import "NTESCommentCellComponent.h"
#import "NTESSeperatorCellComponent.h"
#import "NTESFeedHeaderFooterComponent.h"
#import "NTESFeedSectionComponent.h"

@interface NTESFeedViewController ()
@property (nonatomic,strong)    NTESTableViewComponent *tableViewComponent;
@property (nonatomic,strong)    dispatch_queue_t feedQueue;
@end

@implementation NTESFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    _tableViewComponent = [[NTESTableViewComponent alloc] initWithTableView:self.tableView];
    _tableViewComponent.cellHeightCacheEnabled = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(add)];
    _feedQueue =dispatch_queue_create("com.netease.feed", 0);
    [self mockData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)mockData
{
    dispatch_async(_feedQueue, ^{
        NSArray *feeds = [[NTESFeedMocker shared] mockFeeds:500];
        NSArray *sections = [self sectionsByFeeds:feeds];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDate *date = [NSDate date];
            [self.tableViewComponent setSections:sections];
            NTESLogDebug(@"refresh sections %zd time cost %lf",[sections count],[[NSDate date] timeIntervalSinceDate:date]);
        });
    });
}

- (void)add
{
    dispatch_async(_feedQueue, ^{
        NSArray *feeds = [[NTESFeedMocker shared] mockFeeds:1];
        NSArray *sections = [self sectionsByFeeds:feeds];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDate *date = [NSDate date];
            [self.tableViewComponent addSectionsInFront:sections];
            NTESLogDebug(@"add sections %zd time cost %lf",[sections count],[[NSDate date] timeIntervalSinceDate:date]);
        });
    });
}

- (NSArray *)sectionsByFeeds:(NSArray *)feeds
{
    NTESLogDebug(@"begin generate sections");
    NSMutableArray *sections = [NSMutableArray array];
    for (NTESFeed *feed in feeds)
    {
        static int index = 0;
        index++;
        
        NTESFeedSectionComponent *section = [[NTESFeedSectionComponent alloc] init];
        
        //header
        {
            NSString *text = [NSString stringWithFormat:@"header %d",index];
            NTESFeedHeaderFooterComponent *view = [NTESFeedHeaderFooterComponent component:text];
            section.header = view;
        }
        
        //footer
        {
            NSString *text = [NSString stringWithFormat:@"footer %d",index];
            NTESFeedHeaderFooterComponent *view = [NTESFeedHeaderFooterComponent component:text];
            section.footer = view;
        }
        
        //头像
        {
            NTESAvatarCellComponent *component = [[NTESAvatarCellComponent alloc] init];
            component.feed = feed;
            [component measure];
            [section addComponent:component];
        }
        
        //内容
        {
            if ([feed.text length])
            {
                NTESContentCellComponent *component = [[NTESContentCellComponent alloc]init];
                component.feed = feed;
                [component measure];
                [section addComponent:component];
            }
        }
        //图片
        {
            if ([feed.images count])
            {
                NTESImagesCellComponent *component = [[NTESImagesCellComponent alloc]init];
                component.feed = feed;
                [component measure];
                [section addComponent:component];
            }
        }
        //评论
        {
            NTESCommentCellComponent *component = [[NTESCommentCellComponent alloc]init];
            component.feed = feed;
            [component measure];
            [section addComponent:component];
        }
        
        //分割线
        {
            NTESSeperatorCellComponent *component = [[NTESSeperatorCellComponent alloc]init];
            component.feed = feed;
            [component measure];
            [section addComponent:component];
        }
        [sections addObject:section];
    }
    NTESLogDebug(@"end generate sections");
    return sections;
}



@end
