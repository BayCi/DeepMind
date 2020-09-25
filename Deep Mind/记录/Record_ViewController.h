//
//  Record_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/23.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Record_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *label3;
    UISegmentedControl *segmented;
    UITableView *tableView1;
    UITableView *tableView2;
    UITableView *tableView3;
    
    UITableViewCell *cell1;
    UITableViewCell *cell2;
    UITableViewCell *cell3;
}

@end

NS_ASSUME_NONNULL_END
