//
//  ViewController.m
//  Refresh
//
//  Created by lujh on 2018/1/10.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <MJRefresh.h>

#import "ViewController.h"

#import "RefreshHeaderView.h"

static const CGFloat MJDuration = 2.0;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView  *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubviews];
}

#pragma mark -初始化Subviews

- (void)setupSubviews
{
    // tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    // 防止点击cell的时候 tableview滚动
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    RefreshHeaderView *header = [RefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //    // 设置文字
    //    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    //    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    //    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    //
    //    // 设置字体
    //    header.stateLabel.font = [UIFont systemFontOfSize:15];
    //    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    //
    //    // 设置颜色
    //    header.stateLabel.textColor = [UIColor redColor];
    //    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
}

- (void)loadNewData
{
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

@end
