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

typedef enum : NSUInteger {
    UP,
    DOWN,
} ScrollDirection;//滚动方向

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UIView *orderStatusBgView;
@property (strong, nonatomic) UIView *shadeView;
@property (assign, nonatomic) ScrollDirection *scrollDirection;

//上一次滚动的数据
@property (assign, nonatomic) float lastContentOffset;

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

    //地图
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];

    //白色遮罩(tableView往上滚动时显示)
    self.shadeView = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.shadeView.alpha = 0;
    self.shadeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shadeView];

    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 22, self.screenWidth - 15 * 2, self.screenHeight - 22)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];

    [self.tableView registerNib:[UINib nibWithNibName:@"FirstCell" bundle:nil] forCellReuseIdentifier:@"FirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NormalCell" bundle:nil] forCellReuseIdentifier:@"NormalCell"];

    //利用透明视图占位，显示下层的地图
    UILabel *tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth - 15 * 2, 450)];
    tableHeaderView.alpha = 0;
    self.tableView.tableHeaderView = tableHeaderView;

    //订单状态背景视图
    self.orderStatusBgView = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.screenWidth, 90)];
    self.orderStatusBgView.alpha = 0;
    self.orderStatusBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.orderStatusBgView];

    UIButton *orderStatusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 45, 150, 40)];
    [orderStatusBtn setTitle:@"等待支付 >" forState:UIControlStateNormal];
    [orderStatusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.orderStatusBgView addSubview:orderStatusBtn];

    //返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 22, 40, 40)];
    [backBtn setTitle:@"<" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor lightGrayColor]];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"-->> scrollView.contentOffset:%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    NSLog(@"-->> scrollViewDidEndDragging 3 - decelerate:%d - y:%f",decelerate, scrollView.contentOffset.y);
//    if (decelerate) {//滚动减速
//        return;
//    }

    if (self.lastContentOffset < scrollView.contentOffset.y) {//向上滚动
        NSLog(@"-->> 向上滚动");
        //show tableHeaderView
        [UIView animateWithDuration:0.5 animations:^{
            self.orderStatusBgView.alpha = 1;
            self.shadeView.alpha = 1;
            scrollView.contentOffset = CGPointMake(0, 360);
        }];

    }else{//向下滚动

        NSLog(@"-->> 向下滚动");
        //hide tableHeaderView
        [UIView animateWithDuration:0.5 animations:^{
            self.orderStatusBgView.alpha = 0;
            self.shadeView.alpha = 0;
            scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastContentOffset = scrollView.contentOffset.y;
    NSLog(@"-->> scrollViewWillBeginDragging 1 - y:%f", scrollView.contentOffset.y);
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"-->> scrollViewWillEndDragging 2 - y:%f - velocity:%f - targetContentOffset:%f", scrollView.contentOffset.y, velocity.y, targetContentOffset->y);
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"-->> scrollViewWillBeginDecelerating 4");
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"-->> scrollViewDidEndDecelerating 5");
//}

@end
