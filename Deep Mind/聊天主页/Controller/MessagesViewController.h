//
//  MessagesViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessagesViewController : UITableViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *Commodity_image;
    NSMutableArray *Communication;//tableView呈现的聊天内容
    UIButton *Commodity;
    UIImageView *Want_background;//
    UIButton *add;
    NSDictionary *tags;//存放标签的字典
    NSDictionary *problems;//问题库
    NSDictionary *choices;//选项库
    NSIndexPath *indexPath;
    UIImageView *buttonView;//呈放abcd四个按钮的View容器
    UIButton *button1;//按钮A
    UIButton *button2;//按钮B
    UIButton *button3;//按钮C
    UIButton *button4;//按钮D
    
    NSArray *Know;//了解程度的选项
    NSArray *Know_Problem;//了解程度的问题
    
    NSArray *Price;//价格的选项
    NSArray *Price_Problem;//价格的问题
    
    NSArray *Want;//心动原因的选项
    NSArray *Want_Problem;//心动原因的问题
    
    NSArray *Category;//类别的选项
    NSArray *Category_Problem;//类别的问题
    
    NSArray *Hours;//使用时长的选项
    NSArray *Hours_Problem;//使用时长的问题
}
@property (nonatomic)bool display_state;//商品信息窗口显示状态
@property (nonatomic)bool tag_state;//标签选中状态
@property (nonatomic)bool add_state;//标签选中状态
@property (nonatomic)int X;//循环次数（即问题的个数）
@property (nonatomic)int last_random;//循环次数（即问题的个数）
@property (nonatomic,strong) UIImagePickerController *pickerController;

@property (nonatomic)float price_value;//价格的影响值
//@property (nonatomic)float want_reason_value;//心动原因的影响值
@property (nonatomic)float use_time_value;//使用时长的影响值
@property (nonatomic)float know_value;//了解程度的影响值
@end

NS_ASSUME_NONNULL_END
