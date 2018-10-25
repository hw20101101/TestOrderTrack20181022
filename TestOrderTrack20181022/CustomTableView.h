//
//  CustomTableView.h
//  AIIDemo 自定义tableView，实现事件隔层传递
//
//  Created by 快摇002 on 2018/10/23.
//  Copyright © 2018 胡启龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableView : UITableView

@property (nonatomic, copy) NSArray *passthroughViews;

@end

NS_ASSUME_NONNULL_END
