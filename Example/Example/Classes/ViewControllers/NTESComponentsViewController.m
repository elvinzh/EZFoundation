//
//  NTESComponentsViewController.m
//  Example
//
//  Created by amao on 2018/8/22.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESComponentsViewController.h"
#import "NTESFoundation.h"
#import "NTESItemComponent.h"

@interface NTESComponentsViewController ()<NTESTableViewComponentDelegate>
@property (nonatomic,strong)    UITableView *tableView;
@property (nonatomic,strong)    NTESTableViewComponent *component;
@end

@implementation NTESComponentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"UITableView 组件测试";
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.component = [[NTESTableViewComponent alloc] initWithTableView:self.tableView];
    self.component.delegate = self;
    
    NTESTableViewSectionComponent *section = [[NTESTableViewSectionComponent alloc] init];
    section.components = @[[NTESItemComponent component:@"添加单个 cell"
                                                 vcName:@"NTESTextTableSingleAddViewController"],
                           [NTESItemComponent component:@"插入单个 cell"
                                                 vcName:@"NTESTextTableSingleInsertViewController"],
                           [NTESItemComponent component:@"批量添加 cells"
                                                 vcName:@"NTESTextTableBatchAddBackViewController"],
                           [NTESItemComponent component:@"批量前插 cells"
                                                 vcName:@"NTESTextTableBatchAddFrontViewController"],
                           [NTESItemComponent component:@"添加 section"
                                                 vcName:@"NTESTextTableAddSectionBackViewController"],
                           [NTESItemComponent component:@"前插 section"
                                                 vcName:@"NTESTextTableAddSectionFrontViewController"],
                           [NTESItemComponent component:@"缓存机制"
                                                 vcName:@"NTESDiffableTextViewController"],
                           [NTESItemComponent component:@"动态流"
                                                 vcName:@"NTESFeedViewController"],
                           [NTESItemComponent component:@"ListDiff (Non Cache)"
                                                 vcName:@"NTESListDiffViewController"],
                           [NTESItemComponent component:@"ListDiff (Cache)"
                                                 vcName:@"NTESListCacheDiffViewController"]];
    
    [self.component addSections:@[section]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)tableViewComponent:(NTESTableViewComponent *)tableViewComponent
        didSelectComponent:(NTESTableViewCellComponent *)component
{
    NTESItemComponent *item = [component ntes_asObject:[NTESItemComponent class]];
    if (item)
    {
        NSString *vcName = item.vcName;
        if (vcName)
        {
            Class cls = NSClassFromString(vcName);
            UIViewController *vc = [[cls alloc] init];
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
    }
}
@end
