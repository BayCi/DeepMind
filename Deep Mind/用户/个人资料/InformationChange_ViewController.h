//
//  InformationChange_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/24.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InformationChange_ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UITableViewDelegate>
{

    UILabel *Label;
    UISegmentedControl *Segmented;
    UITableView *TableView;
    UITableViewCell *Cell;
    UIImageView *user_photo;
}
@property (nonatomic,strong) UIImagePickerController *pickerController;
@property (nonatomic,copy)NSString *username;//用户名
@property (nonatomic)bool state;//用户登陆状态
@property (nonatomic,copy)NSString *age;//年龄
@property (nonatomic,copy)NSString *sex;//性别
@property (nonatomic,copy)NSString *monthly_income;//月收入
@property (nonatomic,copy)NSString *tel;//电话号
@end

NS_ASSUME_NONNULL_END
