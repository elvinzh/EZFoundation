//
//  ViewController.m
//  Example
//
//  Created by amao on 2016/12/16.
//  Copyright © 2016年 amao. All rights reserved.
//

#import "ViewController.h"
#import "NTESFoundation.h"
#import "NTESItemComponent.h"


@interface ViewController ()<NTESTableViewComponentDelegate>
@property (nonatomic,strong)    UITableView *tableView;
@property (nonatomic,strong)    NTESTableViewComponent *component;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"测试";
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.component = [[NTESTableViewComponent alloc] initWithTableView:self.tableView];
    self.component.delegate = self;
    
    NTESTableViewSectionComponent *section = [[NTESTableViewSectionComponent alloc] init];
    section.components = @[[NTESItemComponent component:@"UITableView 组件"
                                                vcName:@"NTESComponentsViewController"],
                           [NTESItemComponent component:@"导航栏"
                                                 vcName:@"NTESNavigationBarTestViewController"]];
    
    [self.component addSections:@[section]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
