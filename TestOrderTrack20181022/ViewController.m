//
//  ViewController.m
//  TestOrderTrack20181022
//
//  Created by 快摇002 on 2018/10/22.
//  Copyright © 2018 aiitec. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "FirstCell.h"
#import "NormalCell.h"
#import "CustomTableView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;


/**
 订单状态背景视图
 */
@property (strong, nonatomic) UIView *orderStatusBgView;


/**
 遮罩视图
 */
@property (strong, nonatomic) UIView *shadeView;


/**
 苹果地图
 */
@property (strong, nonatomic) MKMapView *mapView;


/**
 自定义 tableView，实现事件隔层传递
 */
@property (strong, nonatomic) CustomTableView *tableView;


/**
 tableView 上一次滚动的位置
 */
@property (assign, nonatomic) float lastContentOffsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.screenWidth = self.view.frame.size.width;
    self.screenHeight = self.view.frame.size.height;
    [self initSubView];
}

- (void)initSubView{

    //苹果地图
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];

    //白色遮罩(tableView往上滚动时显示)
    self.shadeView = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.shadeView.alpha = 0;
    self.shadeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shadeView];

    CGFloat tableViewX = 15;
    CGFloat tableViewY = 32;

    //tableView
    self.tableView = [[CustomTableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, self.screenWidth - tableViewX * 2, self.screenHeight - tableViewY)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    //禁止 tableView 滚动反弹
    self.tableView.bounces = NO;
    //使 tableView 滚动时的减速时间大大减少
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstCell" bundle:nil] forCellReuseIdentifier:@"FirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NormalCell" bundle:nil] forCellReuseIdentifier:@"NormalCell"];
    [self.view addSubview:self.tableView];

    //利用透明视图占位，显示下层的地图
    UILabel *tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, 450)];
    tableHeaderView.alpha = 0;
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.passthroughViews = @[self.mapView, self.shadeView];

    //订单状态背景视图
    self.orderStatusBgView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, 120)];
    self.orderStatusBgView.alpha = 0;
    self.orderStatusBgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.orderStatusBgView];

    UIButton *orderStatusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 150, 40)];
    [orderStatusBtn setTitle:@"等待支付 >" forState:UIControlStateNormal];
    [orderStatusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.orderStatusBgView addSubview:orderStatusBtn];

    //返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, 40, 40)];
    [backBtn setTitle:@"<" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:backBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120;
    } else {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        return cell;
    } else {
        NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalCell"];
        return cell;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    if (targetContentOffset->y >= self.lastContentOffsetY && targetContentOffset->y != 0) {//向上滚动

        if (targetContentOffset->y >= 360) {
            [self updateViewAlpha:1];//显示视图

        } else {
            [UIView animateWithDuration:0.5 animations:^{
                [self updateViewAlpha:1];//显示视图
                targetContentOffset->y = 360;
            }];
        }

    } else {//向下滚动

        [UIView animateWithDuration:0.5 animations:^{
            [self updateViewAlpha:0];//隐藏视图
            targetContentOffset->y = 0;
        }];
    }

    self.lastContentOffsetY = targetContentOffset->y;
}

- (void)updateViewAlpha:(int)alpha{
    self.orderStatusBgView.alpha = alpha;
    self.shadeView.alpha = alpha;
}

@end
