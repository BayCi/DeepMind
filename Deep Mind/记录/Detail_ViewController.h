//
//  Detail_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/10/14.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Detail_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    UITableViewCell *Cell;
    UIImageView *edit;
}
@end

NS_ASSUME_NONNULL_END
