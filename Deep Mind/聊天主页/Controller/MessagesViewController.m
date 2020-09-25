//
//  MessagesViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "MessagesViewController.h"
#import "StarEvaluator.h"
#import "JJOptionView.h"
//#import "JJOptionView/JJOptionView.h"
#import "ChatMessageCell.h"
#import "ChatMessage.h"
#import "Date_extension.h"
#import "DateHeaderLabel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#define  display_state  true;//商品信息窗口显示状态
#define  PriceValue 1;            //自定义价格的影响值变化幅度
#define  Know_Value 1;      //自定义了解程度的影响值变化幅度
#define  User_timeValue 1;        //自定义使用时长的影响值变化幅度

double score = 0;
double sumsScore = 0;

float knowscore = 0;//用户对商品了解程度的值

int price_count = 1;
int know_count = 1;
int hours_count = 1;

@interface MessagesViewController ()<StarEvaluatorDelegate,JJOptionViewDelegate>
{
    UIButton *tag1;
    UIButton *tag2;
    UIButton *tag3;
    UIButton *tag4;
    UIButton *tag5;
    
    NSDate *time;//时间的实例
    UITextField *price;
}
//@property (strong, nonatomic) NSMutableArray<ChatMessage *> *messages;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSMutableArray *messagesFromServer;




@end

@implementation MessagesViewController
NSString *cellId = @"cellId";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"等等聊";//导航栏title
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏title颜色
    
    UINavigationBar *bar = self.navigationController.navigationBar;//导航栏背景色
    bar.barTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    _X = 0;
    if (self->_know_value <= 3.0f) {
        know_count = 2;
    }
    if (self->_price_value >= 1000) {
        price_count = 2;
    }
    
    [self fetchMessages];
    //[self initMessages];
    [self setupTableView];
    
    if (self->_display_state == false) {//当想要页面为显示状态时，商品基本信息的影响值初始化为0
        [self value_init];
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];//点击手势隐藏键盘
    [self.view addGestureRecognizer:tapRecognizer];
    
    Want_background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 256, 372, 297)];//商品输入信息界面
    Want_background.backgroundColor = [self colorWithHexString:@"FFF6E0" alpha:1.0f];//设置商品输入信息界面的背景色
    //Want.backgroundColor = [UIColor redColor];
    Want_background.layer.cornerRadius = 15.0;//设置商品输入信息界面的边角弧度
    Want_background.userInteractionEnabled = YES;//设置商品输入信息界面的Want UIImageView响应事件
    [self.view addSubview:Want_background];
    if (self->_display_state == true) {
        [Want_background setHidden:true];//设置商品信息窗口隐藏
    }
    
    UILabel *Currency_symbol = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 20, 30)];//货币符号标签
    Currency_symbol.text = @"¥";
    Currency_symbol.textColor = [UIColor blackColor];
    [Currency_symbol setFont:[UIFont systemFontOfSize:30]];//设置货币符号标签的字体大小
    [Want_background addSubview:Currency_symbol];
    
    price = [[UITextField alloc]initWithFrame:CGRectMake(40, 20, 150, 30)];//商品价格文本框
    [price setKeyboardType:(UIKeyboardTypeNumberPad)];//设置商品价格文本框的键盘样式
    price.clearButtonMode = UITextFieldViewModeAlways;//设置商品价格文本框的键盘隐藏
    price.textColor = [UIColor blackColor];
    //price.placeholder = @"0.00";
    NSMutableAttributedString *price_placeholder = [[NSMutableAttributedString alloc]initWithString:@"0.00" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    price.attributedPlaceholder = price_placeholder;
    [price setFont:[UIFont systemFontOfSize:30]];//设置价格标签的字体大小
    [Want_background addSubview:price];
    
    Commodity_image = [[UIImageView alloc]init];//商品图片
    Commodity_image.backgroundColor = [UIColor whiteColor];
    Commodity_image.image = [UIImage imageNamed:@"commodity.png"];
    Commodity = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    Commodity.frame = CGRectMake(282, 20, 60, 60);
    [Commodity setBackgroundColor:[UIColor whiteColor]];
    //[Commodity setTintColor:[UIColor whiteColor]];
    [Commodity setBackgroundImage:Commodity_image.image forState:(UIControlStateNormal)];
    [Want_background addSubview:Commodity];
    [Commodity addTarget:self action:@selector(image_edit) forControlEvents:(UIControlEventTouchUpInside)];
    
    UILabel *Category = [[UILabel alloc]initWithFrame:CGRectMake(40, 80, 40, 10)];
    Category.text = @"类别";
    Category.textColor = [UIColor grayColor];
    [Category setFont:[UIFont systemFontOfSize:15]];//设置类别标签的字体大小
    [Want_background addSubview:Category];
    
    JJOptionView *category_option = [[JJOptionView alloc]initWithFrame:CGRectMake(120, 77, 120, 15)];//类别下拉列表
    category_option.titleColor = [UIColor blackColor];
    category_option.dataSource = @[@"衣物穿搭",@"食品",@"出行居住",@"运动健身",@"兴趣娱乐",@"数码产品",@"其他"];
    [category_option setTitleFontSize:12];
    category_option.delegate = self;
    [Want_background addSubview:category_option];
    
    UILabel *Want_reason = [[UILabel alloc]initWithFrame:CGRectMake(40, 120, 40, 10)];
    Want_reason.text = @"心动";
    Want_reason.textColor = [UIColor grayColor];
    [Want_reason setFont:[UIFont systemFontOfSize:15]];//设置心动标签的字体大小
    [Want_background addSubview:Want_reason];
    
    [self tags_init];//心动标签初始化
    [Want_background addSubview:tag1];
    [Want_background addSubview:tag2];
    [Want_background addSubview:tag3];
    [Want_background addSubview:tag4];
    [Want_background addSubview:tag5];
    
    add = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    add.layer.cornerRadius = 8.0f;
    add.frame = CGRectMake(40+Want_reason.frame.size.width, 120+Want_reason.frame.size.height+5, 30, 30);
//    add.frame = CGRectMake(120+tag3.frame.size.width+5+tag4.frame.size.width+10, 115+tag2.frame.size.height+5, 25, 25);
    //[add setFont:[UIFont systemFontOfSize:12.0f]];
    [add setBackgroundImage:[UIImage imageNamed:@"isShow.png"]  forState:(UIControlStateNormal)];
    if (tag4.state == UIControlStateSelected) {
        [add setBackgroundColor:[UIColor clearColor]];
    }else
        [add setBackgroundColor:[UIColor clearColor]];
    
//    [add.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
//    [add.layer setBorderWidth:1];
//    [add.layer setBorderColor:[UIColor grayColor].CGColor];
    [add setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [add setTitleColor:[UIColor yellowColor] forState:(UIControlStateSelected)];
    [add setTintColor:[UIColor whiteColor]];
    [Want_background addSubview:add];
    [add addTarget:self action:@selector(add) forControlEvents:(UIControlEventTouchUpInside)];
    
    UILabel *Use_time = [[UILabel alloc]initWithFrame:CGRectMake(40, 190, 80, 10)];
    Use_time.text = @"使用时长";
    Use_time.textColor = [UIColor grayColor];
    [Use_time setFont:[UIFont systemFontOfSize:15]];//设置使用时长标签的字体大小
    [Want_background addSubview:Use_time];
    
    JJOptionView *useTime_Option = [[JJOptionView alloc]initWithFrame:CGRectMake(120, 189, 120, 15)];//使用时长下拉列表
    useTime_Option.titleColor = [UIColor blackColor];
    useTime_Option.dataSource = @[@"一次性",@"可持续使用",@"可转卖"];
    [useTime_Option setTitleFontSize:12];
    useTime_Option.delegate = self;
    [Want_background addSubview:useTime_Option];
    
    UILabel *Know_situation = [[UILabel alloc]initWithFrame:CGRectMake(40, 230, 80, 10)];
    Know_situation.text = @"了解程度";
    Know_situation.textColor = [UIColor grayColor];
    [Know_situation setFont:[UIFont systemFontOfSize:15]];//设置了解程度标签的字体大小
    [Want_background addSubview:Know_situation];
    
    StarEvaluator *star = [[StarEvaluator alloc] initWithFrame:CGRectMake(110, 225, 140, 25)];
    star.delegate = self;
    star.animate = YES;
    [Want_background addSubview:star];
    
    UIButton *Send = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    Send.layer.cornerRadius = 20.0;
    Send.frame = CGRectMake(272, 245, 80, 40);
    [Send setTitle:@"发送" forState:(UIControlStateNormal)];
    [Send setBackgroundColor:[self colorWithHexString:@"F2C200" alpha:1.0f]];
    [Send setTintColor:[UIColor whiteColor]];
    [Want_background addSubview:Send];
    [Send addTarget:self action:@selector(send) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    button1 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//按钮A
//    button1.frame = CGRectMake(2, 510, 92, 92);
    button1.frame = CGRectMake(35, 20, 140, 60);
    [button1 setTitle:@"A" forState:(UIControlStateNormal)];
    [button1 setFont:[UIFont systemFontOfSize:25]];
    [button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    button1.layer.cornerRadius = 30.0;//设置登陆按钮的边角弧度
    button1.backgroundColor = [UIColor whiteColor];//按钮背景颜色：自定义蛋黄色
    
//    button1.layer.shadowColor = [UIColor grayColor].CGColor;//设置按钮阴影
//    button1.layer.shadowPath = [UIBezierPath bezierPathWithRect:button1.bounds].CGPath;
//    button1.layer.shadowOffset = CGSizeMake(0, 10);
//    button1.layer.shadowRadius = 5;
//    button1.layer.shadowOpacity = 0.5;
//    button1.layer.masksToBounds = NO;
    
    [button1.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [button1.layer setBorderWidth:5];
//    CGColorSpaceRef  colorSpaceRef1 = CGColorSpaceCreateDeviceRGB();
//    CGColorRef color1 = CGColorCreate(colorSpaceRef1, (CGFloat[]){1,0,0,1});
    [button1.layer setBorderColor:[self colorWithHexString:@"BFE5FA" alpha:0.5].CGColor];
    [button1 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
//    [self.view addSubview:button1];
    if (self->_display_state == false) {
        [button1 setHidden:YES];
    }
    [button1 addTarget:self action:@selector(A_click) forControlEvents:(UIControlEventTouchUpInside)];

    button2 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//按钮B
    button2.frame = CGRectMake(200, 20, 140, 60);
    [button2 setTitle:@"B" forState:(UIControlStateNormal)];
    [button2 setFont:[UIFont systemFontOfSize:25]];
    button2.layer.cornerRadius = 30.0;//设置登陆按钮的边角弧度
    button2.backgroundColor = [UIColor whiteColor];//按钮背景颜色：自定义蛋黄色
    
//    button2.layer.shadowColor = [UIColor grayColor].CGColor;//设置按钮阴影
//    button2.layer.shadowPath = [UIBezierPath bezierPathWithRect:button1.bounds].CGPath;
//    button2.layer.shadowOffset = CGSizeMake(0, 10);
//    button2.layer.shadowRadius = 5;
//    button2.layer.shadowOpacity = 0.5;
//    button2.layer.masksToBounds = NO;
    
    [button2.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [button2.layer setBorderWidth:5];
    [button2.layer setBorderColor:[self colorWithHexString:@"BFE5FA" alpha:0.5].CGColor];
    [button2 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button2 setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
//    [self.view addSubview:button2];
    if (self->_display_state == false) {
        [button2 setHidden:YES];
    }
    [button2 addTarget:self action:@selector(B_click) forControlEvents:(UIControlEventTouchUpInside)];

    button3 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//按钮C
    button3.frame = CGRectMake(35, 100, 140, 60);
    [button3 setTitle:@"C" forState:(UIControlStateNormal)];
    [button3 setFont:[UIFont systemFontOfSize:25]];
    button3.layer.cornerRadius = 30.0;//设置登陆按钮的边角弧度
    button3.backgroundColor = [UIColor whiteColor];//登陆按钮背景颜色：自定义蛋黄色

//    button3.layer.shadowColor = [UIColor grayColor].CGColor;//设置按钮阴影
//    button3.layer.shadowPath = [UIBezierPath bezierPathWithRect:button1.bounds].CGPath;
//    button3.layer.shadowOffset = CGSizeMake(0, 10);
//    button3.layer.shadowRadius = 5;
//    button3.layer.shadowOpacity = 0.5;
//    button3.layer.masksToBounds = NO;
    
    [button3.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [button3.layer setBorderWidth:5];
    [button3.layer setBorderColor:[self colorWithHexString:@"BFE5FA" alpha:0.5].CGColor];
    [button3 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button3 setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
//    [self.view addSubview:button3];
    if (self->_display_state == false) {
        [button3 setHidden:YES];
    }
    [button3 addTarget:self action:@selector(C_click) forControlEvents:(UIControlEventTouchUpInside)];

    button4 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//按钮D
    button4.frame = CGRectMake(200, 100, 140, 60);
    [button4 setTitle:@"D" forState:(UIControlStateNormal)];
    [button4 setFont:[UIFont systemFontOfSize:25]];
    button4.layer.cornerRadius = 30.0;//设置登陆按钮的边角弧度
    button4.backgroundColor = [UIColor whiteColor];//登陆按钮背景颜色：自定义蛋黄色

    //初始button3，4的样式状态
    [button3 setBackgroundColor:[self colorWithHexString:@"CCCCCC" alpha:1.0f]];
    button3.enabled = NO;
    [button4 setBackgroundColor:[self colorWithHexString:@"CCCCCC" alpha:1.0F]];
    button4.enabled = NO;
    
//    button4.layer.shadowColor = [UIColor grayColor].CGColor;//设置按钮阴影
//    button4.layer.shadowPath = [UIBezierPath bezierPathWithRect:button1.bounds].CGPath;
//    button4.layer.shadowOffset = CGSizeMake(0, 10);
//    button4.layer.shadowRadius = 5;
//    button4.layer.shadowOpacity = 0.5;
//    button4.layer.masksToBounds = NO;
    
    [button4.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [button4.layer setBorderWidth:5];
    [button4.layer setBorderColor:[self colorWithHexString:@"BFE5FA" alpha:0.5].CGColor];
    [button4 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button4 setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
//    [self.view addSubview:button4];
    if (self->_display_state == false) {
        [button4 setHidden:YES];
    }
    [button4 addTarget:self action:@selector(D_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    if (self->_display_state == true) {
        //WithFrame:CGRectMake(0, 100, self.view.frame.size.width, 92)
        buttonView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 180)];//用于装ABCD四个按钮的UIView容器
        buttonView.backgroundColor = [UIColor clearColor];
        buttonView.userInteractionEnabled = YES;
        self.tableView.tableFooterView = buttonView;
        [buttonView addSubview:button1];
        [buttonView addSubview:button2];
        [buttonView addSubview:button3];
        [buttonView addSubview:button4];
    }
}

- (void)starEvaluator:(StarEvaluator *)evaluator currentValue:(float)value
{
    NSLog(@"%@",[NSString stringWithFormat:@"评价:%.1f",value]);
    knowscore = value;//了解程度的影响值
}

- (void)value_init{//商品基本信息的影响值初始化为0
    self->_price_value = 0.0;
    self->_use_time_value = 0.0;
    self->_know_value = 0.0;
}

- (void)tags_init{//心动栏的标签初始化
    NSMutableArray *tagArray = [[NSMutableArray alloc]initWithObjects:@"是心动的感觉", @"让人不得不剁手的新品",@"兴趣收集",@"最近很潮",nil];
    tag1 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    tag1.layer.cornerRadius = 8.0f;
    tag1.frame = CGRectMake(120, 115, 100, 20);
    [tag1 setTitle:@"是心动的感觉" forState:(UIControlStateNormal)];
//    tag1.frame = CGRectMake(120, 115, [tagArray objectAtIndex:0], tag1.titleLabel.frame.size.height+10);
    [tag1 setFont:[UIFont systemFontOfSize:12.0f]];
    if (tag1.state == UIControlStateSelected) {
        [tag1 setBackgroundColor:[UIColor clearColor]];
    }else
        [tag1 setBackgroundColor:[UIColor clearColor]];
    
    [tag1.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [tag1.layer setBorderWidth:1];
    [tag1.layer setBorderColor:[UIColor grayColor].CGColor];
    [tag1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [tag1 setTitleColor:[UIColor yellowColor] forState:(UIControlStateSelected)];
    [tag1 setTintColor:[UIColor whiteColor]];
    [tag1 addTarget:self action:@selector(tag1_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    tag2 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    tag2.layer.cornerRadius = 8.0f;
    tag2.frame = CGRectMake(120+tag1.frame.size.width+5, 115, 140, 20);
    [tag2 setFont:[UIFont systemFontOfSize:12.0f]];
    [tag2 setTitle:@"让人不得不剁手的新品" forState:(UIControlStateNormal)];
    if (tag2.state == UIControlStateSelected) {
        [tag2 setBackgroundColor:[UIColor clearColor]];
    }else
        [tag2 setBackgroundColor:[UIColor clearColor]];
    
    [tag2.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [tag2.layer setBorderWidth:1];
    [tag2.layer setBorderColor:[UIColor grayColor].CGColor];
    [tag2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [tag2 setTitleColor:[UIColor yellowColor] forState:(UIControlStateSelected)];
    [tag2 setTintColor:[UIColor whiteColor]];
    [tag2 addTarget:self action:@selector(tag2_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    tag3 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    tag3.layer.cornerRadius = 8.0f;
    tag3.frame = CGRectMake(120, 115+tag1.frame.size.height+5, 70, 20);
    [tag3 setFont:[UIFont systemFontOfSize:12.0f]];
    [tag3 setTitle:@"兴趣收集" forState:(UIControlStateNormal)];
    if (tag3.state == UIControlStateSelected) {
        [tag3 setBackgroundColor:[UIColor clearColor]];
    }else
        [tag3 setBackgroundColor:[UIColor clearColor]];
    
    [tag3.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [tag3.layer setBorderWidth:1];
    [tag3.layer setBorderColor:[UIColor grayColor].CGColor];
    [tag3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [tag3 setTitleColor:[UIColor yellowColor] forState:(UIControlStateSelected)];
    [tag3 setTintColor:[UIColor whiteColor]];
    [tag3 addTarget:self action:@selector(tag3_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    tag4 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    tag4.layer.cornerRadius = 8.0f;
    tag4.frame = CGRectMake(120+tag3.frame.size.width+5, 115+tag2.frame.size.height+5, 70, 20);
    [tag4 setFont:[UIFont systemFontOfSize:12.0f]];
    [tag4 setTitle:@"最近很潮" forState:(UIControlStateNormal)];
    if (tag4.state == UIControlStateSelected) {
        [tag4 setBackgroundColor:[UIColor clearColor]];
    }else
        [tag4 setBackgroundColor:[UIColor clearColor]];
    
    [tag4.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [tag4.layer setBorderWidth:1];
    [tag4.layer setBorderColor:[UIColor grayColor].CGColor];
    [tag4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [tag4 setTitleColor:[UIColor yellowColor] forState:(UIControlStateSelected)];
    [tag4 setTintColor:[UIColor whiteColor]];
    [tag4 addTarget:self action:@selector(tag4_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    tag5 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    tag5.layer.cornerRadius = 8.0f;
    //tag5.frame = CGRectMake(120+tag3.frame.size.width+5+tag4.frame.size.width+5, 115+tag2.frame.size.height+5, 70, 20);
    [tag5 setFont:[UIFont systemFontOfSize:12.0f]];
    [tag5 setTitle:@"" forState:(UIControlStateNormal)];
    if (tag5.state == UIControlStateSelected) {
        [tag5 setBackgroundColor:[UIColor clearColor]];
    }else
        [tag5 setBackgroundColor:[UIColor clearColor]];
    
    [tag5.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [tag5.layer setBorderWidth:1];
    [tag5.layer setBorderColor:[UIColor grayColor].CGColor];
    [tag5 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [tag5 setTitleColor:[UIColor yellowColor] forState:(UIControlStateSelected)];
    [tag5 setTintColor:[UIColor whiteColor]];
    [tag5 addTarget:self action:@selector(tag5_click) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)tag1_click{//标签1点击响应事件
    if (self->_tag_state == NO) {
        tag1.backgroundColor = [self colorWithHexString:@"FFDA5C" alpha:1.0f];
        self->_tag_state = YES;
    }else if (self->_tag_state == YES){
        tag1.backgroundColor = [UIColor clearColor];
        self->_tag_state = NO;
    }
}
- (void)tag2_click{//标签2点击响应事件
    if (self->_tag_state == NO) {
        tag2.backgroundColor = [self colorWithHexString:@"FFDA5C" alpha:1.0f];
        self->_tag_state = YES;
    }else if (self->_tag_state == YES){
        tag2.backgroundColor = [UIColor clearColor];
        self->_tag_state = NO;
    }
}
- (void)tag3_click{//标签3点击响应事件
    if (self->_tag_state == NO) {
        tag3.backgroundColor = [self colorWithHexString:@"FFDA5C" alpha:1.0f];
        self->_tag_state = YES;
    }else if (self->_tag_state == YES){
        tag3.backgroundColor = [UIColor clearColor];
        self->_tag_state = NO;
    }
}
- (void)tag4_click{//标签4点击响应事件
    if (self->_tag_state == NO) {
        tag4.backgroundColor = [self colorWithHexString:@"FFDA5C" alpha:1.0f];
        self->_tag_state = YES;
    }else if (self->_tag_state == YES){
        tag4.backgroundColor = [UIColor clearColor];
        self->_tag_state = NO;
    }
}
- (void)tag5_click{//标签5点击响应事件
    if (self->_tag_state == NO) {
        tag5.backgroundColor = [self colorWithHexString:@"FFDA5C" alpha:1.0f];
        self->_tag_state = YES;
    }else if (self->_tag_state == YES){
        tag5.backgroundColor = [UIColor clearColor];
        self->_tag_state = NO;
    }
}

- (void)add{
    if (self->_add_state == false) {
        UIAlertController *add_tag = [UIAlertController alertControllerWithTitle:@"请输入新标签：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        add_tag.view.tintColor = [UIColor systemBlueColor];
        UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSArray *let;
        let = add_tag.textFields;
        UITextField *field = let[0];
            self->tag5.frame = CGRectMake(120+self->tag3.frame.size.width+5+self->tag4.frame.size.width+5, 115+self->tag2.frame.size.height+5, field.text.length+60, 20);
        [self->tag5 setTitle:field.text forState:(UIControlStateNormal)];
        [self->add setBackgroundImage:[UIImage imageNamed:@"sub.png"] forState:(UIControlStateNormal)];
        self->_add_state = true;
        [self->tag5 setHidden:NO];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:(@"取消") style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [add_tag addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSLog(@"输入");
        }];
        [add_tag addAction:save];
        [add_tag addAction:cancel];
        [self presentViewController:add_tag animated:YES completion:nil];
        
        
    } else if (self->_add_state == true){
        [tag5 setHidden:YES];
        [add setBackgroundImage:[UIImage imageNamed:@"isShow.png"] forState:(UIControlStateNormal)];
        self->_add_state = false;
    }
    
}

- (void)image_edit{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    //通过图库来采集
    else{
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //弹出pickerViewController
    [self presentViewController:_pickerController animated:YES completion:nil];
}


-(void)A_click{
    [self problem_screening_algorithm:@"A"];
    score += 4;
    sumsScore += 4;
}

-(void)B_click{
    [self problem_screening_algorithm:@"B"];
    score += 3;
    sumsScore += 4;
}

-(void)C_click{
    [self problem_screening_algorithm:@"C"];
    score += 2;
    sumsScore += 4;
}

-(void)D_click{
    [self problem_screening_algorithm:@"D"];
    score += 1;
    sumsScore += 4;
}

- (void)problem_screening_algorithm:(NSString *)swicth{
    NSArray *array = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F", nil];
    NSMutableSet *randomSet = [[NSMutableSet alloc]init];
    //NSLog(@"价格的问题个数：%d",price_count);
    //NSLog(@"了解程度的问题个数：%d",know_count);
    
    while ([randomSet count] < 2) {
        int o = arc4random() % [array count];
        [randomSet addObject:[array objectAtIndex:o]];
    }
    NSArray *randomArray = [randomSet allObjects];
    NSLog(@"抽中的随机数是：%@",randomArray);
    
    double Recommended_Value = 0.0;//系统给出的购物推荐值
    
    NSArray *analyzeArray = [NSArray arrayWithObjects:@"推荐购买指数过低，不推荐您购买该商品。希望您可以暂时放下，未来时机成熟再进行购买。",@"推荐购买指数正常，希望您能冷静，再三考虑之后再做出合适的决定",@"推荐购买指数高，如果你做好了周全的考虑，就不用迟疑了，买买买！", nil];//存放系统分析与建议的数组
    NSArray *problemArray = [NSArray arrayWithObjects:@"Know",@"Price",@"Want",@"Category",@"Hours", nil];//存放问题库分类的数组
    [self problems_base];
    
    if (self->_X >= 0 && self->_X <=4) {
        //random为不同类别问题的数组长度的一个随机生成数
        int random = arc4random() % [[problems valueForKey:[problemArray objectAtIndex:_X]] count];
        //
        
        if (self->_X == 0) {
            [Communication addObject:[[ChatMessage alloc] initWithText:[[Know objectAtIndex:4] valueForKey:swicth] isComing:NO date:time]];
        }else{
            NSLog(@"else时候的last_random的值为：%d",self->_last_random);
            [Communication addObject:[[ChatMessage alloc] initWithText:[[[choices valueForKey:[problemArray objectAtIndex:_X-1]] objectAtIndex:self->_last_random] valueForKey:swicth] isComing:NO date:time]];
            
        }
        [Communication addObject:[[ChatMessage alloc] initWithText:[[problems valueForKey:[problemArray objectAtIndex:_X] ] objectAtIndex:random] isComing:YES date:time]];
        if ([[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] count] == 2) {
            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"A、%@\nB、%@",[[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] valueForKey:@"A"],[[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] valueForKey:@"B"]] isComing:YES date:time]];
            [button3 setBackgroundColor:[self colorWithHexString:@"CCCCCC" alpha:1.0f]];
            button3.enabled = NO;
            [button4 setBackgroundColor:[self colorWithHexString:@"CCCCCC" alpha:1.0F]];
            button4.enabled = NO;
        }else{
            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"A、%@\nB、%@\nC、%@\nD、%@",[[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] valueForKey:@"A"],[[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] valueForKey:@"B"],[[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] valueForKey:@"C"],[[[choices valueForKey:[problemArray objectAtIndex:_X]] objectAtIndex:random] valueForKey:@"D"]] isComing:YES date:time]];
            [button3 setBackgroundColor:[UIColor whiteColor]];
            button3.enabled = YES;
            [button4 setBackgroundColor:[UIColor whiteColor]];
            button4.enabled = YES;
        }
        
        NSLog(@"if语句最后时，random的w值为：%d",random);
        self->_last_random = random;
    }
    if (self->_X == 5) {
        //Recommended_Value = self->_price_value+self->_want_reason_value+self->_use_time_value+self->_know_value;
        Recommended_Value = score / sumsScore;
        
        [Communication addObject:[[ChatMessage alloc] initWithText:[[[choices valueForKey:[problemArray objectAtIndex:_X-1]] objectAtIndex:self->_last_random] valueForKey:swicth] isComing:NO date:time]];
        //弹窗式系统推荐值
        UIAlertController *System_recommended = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"该宝贝的系统推荐购买指数为：%.2lf%@\n%@",Recommended_Value*85,@"%",[analyzeArray objectAtIndex:1]]] preferredStyle:(UIAlertControllerStyleAlert)];
        System_recommended.view.tintColor = [UIColor systemBlueColor];

        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"好的，我知道了👌" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

        }];
        [System_recommended addAction:sure];
        [self presentViewController:System_recommended animated:YES completion:nil];
        
//        if (Recommended_Value*85 >= 80 && Recommended_Value*85 <= 100) {
//            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"该宝贝的系统推荐购买指数为：%.2lf%@\n%@",Recommended_Value*85,@"%",[analyzeArray objectAtIndex:2]] isComing:YES date:time]];
//        }else if (Recommended_Value*85 >= 40 && Recommended_Value*85 < 80){
//            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"该宝贝的系统推荐购买指数为：%.2lf%@\n%@",Recommended_Value*85,@"%",[analyzeArray objectAtIndex:1]] isComing:YES date:time]];
//        }else if (Recommended_Value*85 >= 0 && Recommended_Value*85 < 40){
//            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"该宝贝的系统推荐购买指数为：%.2lf%@\n%@",Recommended_Value*85,@"%",[analyzeArray objectAtIndex:0]] isComing:YES date:time]];
//        }
        
        [button1 setHidden:YES];
        [button2 setHidden:YES];
        [button3 setHidden:YES];
        [button4 setHidden:YES];
    }


    [self assembleGroupedMessages];
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:self.tableView.indexPathForSelectedRow atScrollPosition:(UITableViewScrollPositionBottom) animated:true];
    _X += 1;
}



- (void)send{
    NSLog(@"Sent succeesful!");
    MessagesViewController *mess = [[MessagesViewController alloc]init];
    
    [UIView transitionWithView:self.navigationController.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.type = kCATransitionFade;//淡出效果
        //transition.subtype = kCATransitionFade;
        //[transition setType:@"suckEffect"];//设置动画效果
        [self.navigationController.view.layer addAnimation:transition forKey:@"animation"];
        //[Want_background setHidden:true];
        [self.navigationController pushViewController:mess animated:NO];
        mess->_display_state = display_state;
        mess.navigationItem.hidesBackButton = YES;//隐藏导航栏的返回按钮
        UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithTitle:nil style:(UIBarButtonItemStylePlain) target:self action:@selector(set_click)];
        mess.navigationItem.leftBarButtonItem = add;
        [mess.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"isShow.png"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        
        //传递修改的影响值
        mess->_price_value = [self->price.text floatValue];
        mess->_use_time_value = self->_use_time_value;
        mess->_know_value = knowscore;
        //
    } completion:nil];
    
}

- (void)setupTableView {
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.tableView registerClass:ChatMessageCell.class forCellReuseIdentifier:cellId];
}

-(UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc]init];
        
        //1.设置数据源类型
        _pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //2.设置媒体类型(总共两种类型：图片或视频)
        //_bridge将C语言类型的kUTTypeImage(图片类型)桥接为NSString类型
        _pickerController.mediaTypes = [NSArray arrayWithObject:(
                                                                 __bridge NSString*)kUTTypeImage];
        
        //3.设置代理
        _pickerController.delegate = self;
    }
    return _pickerController;
}

//完成采集图片后的处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    //从info里获取媒体类型
    NSString *type = info[UIImagePickerControllerMediaType];
    //如果媒体类型是图片类型
    if ([type isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        //从info里获取采集图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        //显示到UI界面
        Commodity_image.image = image;
        [Commodity setBackgroundImage:Commodity_image.image forState:(UIControlStateNormal)];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消采集图片后的处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancle");
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)set_click{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)problems_base{//问题库(head)
//    NSDictionary *problems = [[NSDictionary alloc]initWithObjectsAndKeys:Know_Problem,@"Know",Price_Problem,@"Price",Want_Problem,@"Want",Category_Problem,@"Category",Hours_Problem,@"Hours" ,nil];
    
    problems = [[NSDictionary alloc]initWithObjectsAndKeys:Know_Problem,@"Know",Price_Problem,@"Price",Want_Problem,@"Want",Category_Problem,@"Category",Hours_Problem,@"Hours" ,nil];
    choices = [[NSDictionary alloc]initWithObjectsAndKeys:Know,@"Know",Price,@"Price",Want,@"Want",Category,@"Category",Hours,@"Hours" ,nil];
    
    //了解程度
    Know_Problem = [NSArray arrayWithObjects:@"关于产品，您是否有事前查看过详细信息，或者看过测评视频吗？ ",@"您是否有想过心仪的东西买到手后，和您的期望有较大的落差？",@"在现实生活中，您见过这个东西吗？",@"人无圣人，物无完物，产品存在的的缺点，或可能会给您带来的危害，您是否有曾考虑过？",@"如果产品入手一段时间后，发现它并未发挥较大的作用，或者使用体验不是很好，您会后悔吗？", nil];
    NSDictionary * K1= [[NSDictionary alloc]initWithObjectsAndKeys:@"有",@"A",@"无",@"B",nil];
        NSDictionary * K2= [[NSDictionary alloc]initWithObjectsAndKeys:@"有点心虚",@"A",@"不存在的",@"B",nil];
    NSDictionary * K3= [[NSDictionary alloc]initWithObjectsAndKeys:@"经常的事啦（有）",@"A",@"素未谋面（无）",@"B",nil];
    NSDictionary * K4= [[NSDictionary alloc]initWithObjectsAndKeys:@"有",@"A",@"无",@"B",nil];
    NSDictionary * K5= [[NSDictionary alloc]initWithObjectsAndKeys:@"打脸（会）",@"A",@"自豪（不会）",@"B",nil];
    Know = [NSArray arrayWithObjects:K1,K2,K3,K4,K5, nil];
    
    //价格
    Price_Problem = [NSArray arrayWithObjects:@"你的花呗（其他类型的债务）是否还欠钱？",@"你是否有稳定的收入？",@"这个商品是不是你生活里一定需要的呢？",@"这个商品能实实在在地满足你的需求吗？",@"这个商品相比同类商品价格如何？",@"你会因为这笔开销而吃土吗？", nil];
    NSDictionary * P1= [[NSDictionary alloc]initWithObjectsAndKeys:@"负载累累",@"A",@"无债一身轻松",@"B",nil];
    NSDictionary *P2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"有，还挺高",@"A",@"有，维持生活",@"B",@"有，有生活费",@"C",@"没有",@"D", nil];
    NSDictionary * P3= [[NSDictionary alloc]initWithObjectsAndKeys:@"是，没有它我不能活",@"A",@"不是，只是我很喜欢它而已",@"B",nil];
    NSDictionary * P4= [[NSDictionary alloc]initWithObjectsAndKeys:@"完全可以",@"A",@"好像不完全能",@"B",nil];
    NSDictionary * P5= [[NSDictionary alloc]initWithObjectsAndKeys:@"很贵",@"A",@"略贵",@"B",@"差不多",@"C",@"便宜实惠",@"D", nil];
    NSDictionary * P6= [[NSDictionary alloc]initWithObjectsAndKeys:@"会，土还挺好吃的",@"A",@"不会，我还是能正常生活的",@"B",nil];
    Price = [NSArray arrayWithObjects:P1,P2,P3,P4,P5,P6, nil];
    
    //心动原因
     Want_Problem = [NSArray arrayWithObjects:@"你觉得这个商品类型适合你吗？",@"如果没有它，你会很伤心吗？",@"你想买这个东西多久了呢？", nil];
    NSDictionary * W1= [[NSDictionary alloc]initWithObjectsAndKeys:@"超级适合",@"A",@"比较适合",@"B",@"够用",@"C",@"不确定是否适合",@"D",nil];
    NSDictionary * W2= [[NSDictionary alloc]initWithObjectsAndKeys:@"超级伤心",@"A",@"有点伤心",@"B",@"比较遗憾",@"C",@"毫无波动",@"D",nil];
    NSDictionary * W3= [[NSDictionary alloc]initWithObjectsAndKeys:@"儿时的夙愿",@"A",@"几年了吧",@"B",@"几个月",@"C",@"最近",@"D",nil];
    Want = [NSArray arrayWithObjects:W1,W2,W3, nil];
    
    //类别
     Category_Problem = [NSArray arrayWithObjects:@"你手中同类产品足够使用吗？", nil];
    NSDictionary * C1= [[NSDictionary alloc]initWithObjectsAndKeys:@"绰绰有余",@"A",@"足够",@"B",@"还凑合",@"C",@"没有同类物品",@"D",nil];
    Category = [NSArray arrayWithObjects:C1, nil];
    
    //使用时长
     Hours_Problem = [NSArray arrayWithObjects:@"如果您以后用不到，考虑过转手会形成较大的亏损吗？",@"您购买的产品入手后容易转手吗，是否会存在转卖不会出去的现象？",@"是否提前考虑过产品的使用寿命能否满足您的基本需求？",@"如果新鲜感过了以后，这个产品还能发挥出它的作用吗？", nil];
    NSDictionary * H1= [[NSDictionary alloc]initWithObjectsAndKeys:@"亏损较小",@"A",@"亏损较大",@"B",nil];
    NSDictionary * H2= [[NSDictionary alloc]initWithObjectsAndKeys:@"不可能 （极其膨胀）",@"A",@"有可能（心虚）",@"B",nil];
    NSDictionary * H3= [[NSDictionary alloc]initWithObjectsAndKeys:@"是",@"A",@"否",@"B",nil];
    NSDictionary * H4= [[NSDictionary alloc]initWithObjectsAndKeys:@"能",@"A",@"不能",@"B",nil];
    Hours = [NSArray arrayWithObjects:H1,H2,H3,H4, nil];
     //问题库(tail)
     
     //选项库(head)
     
     //选项库(tail)
    
}

- (void)fetchMessages{
    [self problems_base];
    time = [NSDate new];//获取今天的日期
    
    Communication = [[NSMutableArray alloc]initWithObjects:[[ChatMessage alloc] initWithText:@"Hi，我是Wait，请多指教！" isComing:YES  date:time], nil];
    
    //[NSDate dateFromCustomString:@"10/22/2018"]   自定义日期的调用方法
    
    self.messagesFromServer = Communication;
    if (self->_display_state == YES) {
        //[Communication addObject:[[ChatMessage alloc] initWithText:[Know_Problem objectAtIndex:4] isComing:YES date:[NSDate date]]];
        [Communication insertObject:[[ChatMessage alloc] initWithText:[Know_Problem objectAtIndex:4] isComing:YES date:time] atIndex:1];
        if ([[Know objectAtIndex:4] count] == 2) {
            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"A、%@\nB、%@",[[Know objectAtIndex:4] valueForKey:@"A"],[[Know objectAtIndex:4] valueForKey:@"B"]] isComing:YES date:time]];
            
        }else{
            [Communication addObject:[[ChatMessage alloc] initWithText:[NSString stringWithFormat:@"A、%@\nB、%@\nC、%@\nD、%@",[[Know objectAtIndex:4] valueForKey:@"A"],[[Know objectAtIndex:4] valueForKey:@"B"],[[Know objectAtIndex:4] valueForKey:@"C"],[[Know objectAtIndex:4] valueForKey:@"D"]] isComing:YES date:time]];
        }
    }

    [self assembleGroupedMessages];
    [self.tableView reloadData];
}

- (void)assembleGroupedMessages {
    
    NSMutableDictionary *messagesDateDict = [NSMutableDictionary new];
    NSArray *distinctDates;
    distinctDates = [self.messagesFromServer valueForKeyPath:@"@distinctUnionOfObjects.date"];
    
    for (NSDate *date in distinctDates) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", date];
        NSArray *messages = [self.messagesFromServer filteredArrayUsingPredicate:predicate];
        NSLog(@"%@", date);
        NSLog(@"%lu", (unsigned long)messages.count);
        [messagesDateDict setObject:messages forKey:date];
    }
    
    NSArray *sortedDates = [messagesDateDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2] == NSOrderedAscending;
    }];
    self.messages = [NSMutableArray new];
    for (NSData* date in sortedDates){
        [self.messages addObject:messagesDateDict[date]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [DateHeaderLabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *containerView = [UIView new];
    [containerView addSubview:label];
    [label.centerXAnchor constraintEqualToAnchor:containerView.centerXAnchor].active = YES;
    [label.centerYAnchor constraintEqualToAnchor:containerView.centerYAnchor].active = YES;
    
    ChatMessage *chatMessage = self.messages[section][0];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/yyyy";
    label.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:chatMessage.date]];
    
    return containerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.messages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *subArray = self.messages[section];
    return subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatMessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.chatmessage = self.messages[indexPath.section][indexPath.row];
    return cell;
}

- (void)handleBackgroundTap:(UITapGestureRecognizer *)sender{
    [price resignFirstResponder];
}

- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {//十六进制色号自定义颜色
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
    NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];
    
    if (match == 0) {return [UIColor clearColor];}
    
    NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
    BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
    BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (rValue && gValue && bValue) {
        return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
    } else {
        return [UIColor clearColor];
    }
}
@end
