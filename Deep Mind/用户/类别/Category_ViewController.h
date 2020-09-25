//
//  Category_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/28.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Category_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView         *expandTable;
    NSMutableArray      *dataSource;
    NSMutableArray      *sectionArray;
    NSMutableArray      *stateArray;
}

@end

NS_ASSUME_NONNULL_END
