//
//  NormalViewController.m
//  TestOrderTrack20181022
//
//  Created by 快摇002 on 2018/11/6.
//  Copyright © 2018 aiitec. All rights reserved.
//

#import "NormalViewController.h"
#import "CustomView.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initSubView];
}

- (void)initSubView{

    UILabel *bottomView = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    bottomView.text = @"bottomView";
    bottomView.textAlignment = NSTextAlignmentCenter;
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewAction)];
    [bottomView addGestureRecognizer:tap];

    /*
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 100, 100)];
    centerView.alpha = 0;
    centerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:centerView];
    */

    CustomView *topView = [[CustomView alloc] initWithFrame:CGRectMake(120, 320, 100, 100)];
    //topView.alpha = 0;
    topView.text = @"topView";
    topView.textAlignment = NSTextAlignmentCenter;
    topView.backgroundColor = [UIColor greenColor];
    topView.passthroughViews = @[bottomView];
    //topView.passthroughViews = @[bottomView, centerView];
    [self.view addSubview:topView];
}

- (void)bottomViewAction{
    NSLog(@"-->> 点击 topView 时，bottomView 可以响应点击事件");
}

@end
