//
//  NTESDiffableTextViewControllerTableViewController.m
//  Example
//
//  Created by amao on 2018/6/15.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESDiffableTextViewController.h"
#import "NTESFoundation.h"
#import "NTESDiffableTextCellComponent.h"

@interface NTESDiffableTextViewController ()
@property (nonatomic,strong)    NTESTableViewComponent *component;
@end

@implementation NTESDiffableTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.component = [[NTESTableViewComponent alloc] initWithTableView:self.tableView];
    
    NTESTableViewSectionComponent *section = [[NTESTableViewSectionComponent alloc] init];
    
    NSMutableArray *components = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++)
    {
        NSString *text = [NSString stringWithFormat:@"测试 NTESTableViewComponent，当前插入数据序号为 %zd",i];
        NTESDiffableTextCellComponent *component = [[NTESDiffableTextCellComponent alloc] init];
        component.text = text;
        [components addObject:component];
    }
    [section addComponents:components];
    [self.component addSections:@[section]];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refresh)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    [self.tableView reloadData];
}

@end
