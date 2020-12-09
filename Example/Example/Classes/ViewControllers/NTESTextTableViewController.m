//
//  NTESTextTableViewController.m
//  Example
//
//  Created by amao on 2017/5/27.
//  Copyright © 2017年 amao. All rights reserved.
//

#import "NTESTextTableViewController.h"
#import "NTESFoundation.h"
#import "NTESTextTableViewCellComponent.h"



@interface NTESTextTableViewController ()
@property (nonatomic,strong)    NTESTableViewComponent *component;
@property (nonatomic,assign)    NSInteger  currentIndex;
@end

@implementation NTESTextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Text";
    
    self.component = [[NTESTableViewComponent alloc] initWithTableView:self.tableView];
    
    NTESTableViewSectionComponent *section = [[NTESTableViewSectionComponent alloc] init];
    [self.component addSections:@[section]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(add:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)add {}

- (void)add:(id)sender
{
    [self add];
}

@end

@implementation NTESTextTableSingleAddViewController
- (void)add
{
    NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",self.currentIndex++];
    NTESTextTableViewCellComponent *component = [NTESTextTableViewCellComponent component:text];
    [[self.component sectionAt:0] addComponents:@[component]];
    [component scroll:UITableViewScrollPositionBottom animated:YES];
}
@end

@implementation NTESTextTableSingleInsertViewController
- (void)add
{
    NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",self.currentIndex++];
    NTESTextTableViewCellComponent *component = [NTESTextTableViewCellComponent component:text];
    NSInteger index = [[self.component sectionAt:0].components count] / 2;
    [[self.component sectionAt:0] insertComponents:@[component] atIndex:index];
    [component scroll:UITableViewScrollPositionBottom animated:YES];
}
@end


@implementation NTESTextTableBatchAddBackViewController
- (void)add
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++)
    {
        NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",self.currentIndex++];
        NTESTextTableViewCellComponent *component = [NTESTextTableViewCellComponent component:text];
        [components addObject:component];
    }
    [[self.component sectionAt:0] addComponents:components];
    [[components lastObject] scroll:UITableViewScrollPositionBottom animated:YES];
}
@end

@implementation NTESTextTableBatchAddFrontViewController
- (void)add
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++)
    {
        NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",self.currentIndex++];
        NTESTextTableViewCellComponent *component = [NTESTextTableViewCellComponent component:text];
         [components addObject:component];
    }
    [[self.component sectionAt:0] addComponentsInFront:components];
    [[components firstObject] scroll:UITableViewScrollPositionBottom animated:YES];
}
@end

@implementation NTESTextTableAddSectionBackViewController
- (void)add
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++)
    {
        NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",self.currentIndex++];
        NTESTextTableViewCellComponent *component = [NTESTextTableViewCellComponent component:text];
         [components addObject:component];
    }
    NTESTableViewSectionComponent *section = [NTESTableViewSectionComponent component:components];
    [self.component addSections:@[section]];
    [section scrollToComponent:section.components.firstObject
              atScrollPosition:UITableViewScrollPositionBottom
                      animated:YES];
}
@end

@implementation NTESTextTableAddSectionFrontViewController
- (void)add
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++)
    {
        NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",self.currentIndex++];
        NTESTextTableViewCellComponent *component = [NTESTextTableViewCellComponent component:text];
        [components addObject:component];
    }
    NTESTableViewSectionComponent *section = [NTESTableViewSectionComponent component:components];
    [self.component addSectionsInFront:@[section]];
    [section scrollToComponent:section.components.firstObject
              atScrollPosition:UITableViewScrollPositionBottom
                      animated:YES];
}
@end



