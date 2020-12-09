//
//  NTESListDiffViewController.m
//  Example
//
//  Created by amao on 2018/7/3.
//  Copyright © 2018年 amao. All rights reserved.
//

#import "NTESListDiffViewController.h"
#import "NTESFoundation.h"
#import "NTESListDiffCellComponent.h"

@interface NTESListDiffViewController ()
@property (nonatomic,strong)    NTESTableViewComponent *component;
@property (nonatomic,strong)    NSArray *items;
@property (nonatomic,assign)    NSInteger index;
@end

@implementation NTESListDiffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.component = [[NTESTableViewComponent alloc] initWithTableView:self.tableView];
    
    NTESTableViewSectionComponent *section = [[NTESTableViewSectionComponent alloc] init];
    [self.component addSections:@[section]];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refresh)];
    
    _items = @[@[@1,@2,@3,@4,@5,@6,@7,@8,@9],
               @[@2,@3,@4,@5,@6,@7,@8,@9,@10],
               @[@4,@5,@6,@7,@8,@9,@2,@1,@3],
               @[@5,@11,@12,@23,@2,@4,@9,@7],
               @[@2,@9,@3,@1,@5,@6,@8],
               @[@2,@9,@3,@1,@5,@6,@8],
               @[@1,@2,@3,@4,@5,@6,@7],
               @[@1,@2,@3,@4,@5,@6,@7,@8,@9],
               @[@2,@3,@4,@5,@6,@7,@8,@9,@10],
               @[@4,@5,@6,@7,@8,@9,@2,@1,@3],
               @[@5,@11,@12,@23,@2,@4,@9,@7],
               @[@2,@9,@3,@1,@5,@6,@8],
               ];
    NSArray *components = [self componentsByNumbers:_items[0]];
    [[self.component sectionAt:0] setComponents:components];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refresh
{
    _index++;
    if (_index >= [_items count])
    {
        _index = 0;
    }
    NSArray *numbers = [_items objectAtIndex:_index];
    NSArray *components = [self componentsByNumbers:numbers];
    [[self.component sectionAt:0] reloadUsingListDiff:components];
}


- (NSArray *)componentsByNumbers:(NSArray *)numbers
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSNumber *number in numbers)
    {
        NTESListDiffCellComponent *component = [self componentByNumber:number];
        [components addObject:component];
    }
    return components;
}

- (NTESListDiffCellComponent *)componentByNumber:(NSNumber *)number
{
    NTESListDiffCellComponent *component = [[NTESListDiffCellComponent alloc] init];
    component.number = number;
    return component;
}

@end


@implementation NTESListCacheDiffViewController
- (NTESListDiffCellComponent *)componentByNumber:(NSNumber *)number
{
    static NSMutableDictionary *caches = nil;
    if (caches == nil)
    {
        caches = [NSMutableDictionary dictionary];
    }
    NTESListDiffCellComponent *component = caches[number];
    if (component == nil)
    {
        component = [[NTESListDiffCellComponent alloc] init];
        component.number = number;
        caches[number] = component;
    }
    return component;
}
@end
