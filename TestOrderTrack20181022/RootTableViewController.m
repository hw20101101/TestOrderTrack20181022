//
//  RootTableViewController.m
//  TestOrderTrack20181022
//
//  Created by 快摇002 on 2018/11/6.
//  Copyright © 2018 aiitec. All rights reserved.
//

#import "RootTableViewController.h"
#import "NormalViewController.h"
#import "MapViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];

    if (indexPath.row == 0) {
        cell.textLabel.text = @"normal view";
    } else {
        cell.textLabel.text = @"map view and table view";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        NormalViewController *vc = [NormalViewController new];
        [self.navigationController pushViewController:vc animated:YES];

    } else {
        MapViewController *vc = [MapViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
