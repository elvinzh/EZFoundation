//
//  NTESNavigationBarTestViewController.m
//  Example
//
//  Created by 张明川 on 2018/5/15.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESNavigationBarTestViewController.h"
#import <NTESNavigationBarConfigProtocolHeader.h>
#import <NTESMacro.h>
@interface NTESNavigationBarTestViewController () <UITableViewDelegate, UITableViewDataSource, NTESNavigationBarConfigProtocol>
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation NTESNavigationBarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _dataSource = [NSMutableArray array];
    
    NTESNavigationBarConfig * config1 = [[NTESNavigationBarConfig alloc] initWithBackgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:nil clear:NO];
    NTESNavigationBarConfig * config2 = [[NTESNavigationBarConfig alloc] initWithBackgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:nil clear:YES];
    NTESNavigationBarConfig * config3 = [[NTESNavigationBarConfig alloc] initWithBackgroundColor:[UIColor blackColor] titleColor:[UIColor whiteColor] titleFont:nil clear:NO];
    NTESNavigationBarConfig * config4 = [[NTESNavigationBarConfig alloc] initWithBackgroundColor:NTESRGB(0xf13838) titleColor:[UIColor whiteColor] titleFont:nil clear:NO];
    NTESNavigationBarConfig * config5 = [[NTESNavigationBarConfig alloc] initWithBackgroundColor:NTESRGB(0x3ec2f9) titleColor:[UIColor whiteColor] titleFont:nil clear:NO];
    NTESNavigationBarConfig * config6 = [[NTESNavigationBarConfig alloc] initWithBackgroundColor:NTESRGB(0x2f213a) titleColor:[UIColor whiteColor] titleFont:nil clear:NO];
    
    [_dataSource addObject:@{@"title" : @"白色",
                             @"config" : config1}];
    [_dataSource addObject:@{@"title" : @"透明",
                             @"config" : config2}];
    [_dataSource addObject:@{@"title" : @"黑色",
                             @"config" : config3}];
    [_dataSource addObject:@{@"title" : @"红色",
                             @"config" : config4}];
    [_dataSource addObject:@{@"title" : @"蓝色",
                             @"config" : config5}];
    [_dataSource addObject:@{@"title" : @"紫色",
                             @"config" : config6}];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NavBarTestCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NavBarTestCell"];
    }
    NSDictionary * dict = [_dataSource objectAtIndex:indexPath.row];
    NTESNavigationBarConfig * config = [dict objectForKey:@"config"];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.textLabel.textColor = config.backgroundColor;
    cell.contentView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = [_dataSource objectAtIndex:indexPath.row];
    NTESNavigationBarConfig * config = [dict objectForKey:@"config"];
    NTESNavigationBarTestViewController * vc = [[NTESNavigationBarTestViewController alloc] init];
    vc.navigationBarConfig = config;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NTESNavigationBarConfig *)ntes_viewControllerNavigationBarConfig
{
    return _navigationBarConfig ? _navigationBarConfig : [NTESNavigationBarConfig defaultConfig];
}

@end
