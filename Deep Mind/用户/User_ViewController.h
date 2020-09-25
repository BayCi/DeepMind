//
//  User_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/23.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *TableView;
    UITableViewCell *Cell;
}
@property (nonatomic,copy)NSString *username;//用户名
@property (nonatomic,copy)NSString *password;//用户密码
@property (nonatomic,copy)NSString *tel;//用户电话号码
@property (nonatomic)bool fresh_state;//用户界面刷新状态
@property (nonatomic)bool state;//用户登陆状态
@property (nonatomic)bool click_state;//用户点击set按钮的状态
@end

NS_ASSUME_NONNULL_END
