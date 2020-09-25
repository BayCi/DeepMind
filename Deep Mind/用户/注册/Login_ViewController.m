//
//  Login_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Login_ViewController.h"
#import "User_ViewController.h"
#import "User_ViewController.h"
@interface Login_ViewController ()
#define  logged_in  true
@end

@implementation Login_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, 374, 553)];//登陆背景图
    background.image = [UIImage imageNamed:@"background_register.png"];
    [self.view addSubview:background];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector((back))];//返回按钮
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];//返回按钮颜色

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 90, 75, 50)];
    label.text = @"注  册";
    [label setFont:[UIFont systemFontOfSize:30]];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    UIImageView *user = [[UIImageView alloc]initWithFrame:CGRectMake(40, 175, 30, 30)];
    user.image = [UIImage imageNamed:@"user.png"];
    [self.view addSubview:user];
    Username = [[UITextField alloc]initWithFrame:CGRectMake(90, 170, 240, 40)];
    [Username setDelegate:self];//设置代理为self
    Username.textColor = [UIColor blackColor];
    Username.backgroundColor = [self colorWithHexString:@"FFFFCC" alpha:0.5];
    Username.font = [UIFont fontWithName:@"OriyaSangamMN-Bold" size:18.0f];
    [Username setBorderStyle:(UITextBorderStyleRoundedRect)];
    Username.clearButtonMode = UITextFieldViewModeAlways;
    Username.alpha = 0.5;
    //Username.placeholder = @"用户名";
    NSMutableAttributedString *Uname = [[NSMutableAttributedString alloc]initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    Username.attributedPlaceholder = Uname;
    [self.view addSubview:Username];
    
    UIImageView *Email = [[UIImageView alloc]initWithFrame:CGRectMake(40, 235, 30, 30)];
    Email.image = [UIImage imageNamed:@"email.png"];
    [self.view addSubview:Email];
    Email_address = [[UITextField alloc]initWithFrame:CGRectMake(90, 230, 240, 40)];
    [Email_address setDelegate:self];//设置代理为self
    Email_address.textColor = [UIColor blackColor];
    Email_address.backgroundColor = [self colorWithHexString:@"FFFFCC" alpha:0.5];
    Email_address.font = [UIFont fontWithName:@"OriyaSangamMN-Bold" size:18.0f];
    [Email_address setBorderStyle:(UITextBorderStyleRoundedRect)];
    Email_address.clearButtonMode = UITextFieldViewModeAlways;
    Email_address.alpha = 0.5;
    //Email_address.placeholder = @"邮箱地址";
    NSMutableAttributedString *Eaddress = [[NSMutableAttributedString alloc]initWithString:@"邮箱地址" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    Email_address.attributedPlaceholder = Eaddress;
    [self.view addSubview:Email_address];
    
    UIImageView *password = [[UIImageView alloc]initWithFrame:CGRectMake(40, 295, 30, 30)];
    password.image = [UIImage imageNamed:@"password.png"];
    [self.view addSubview:password];
    Password = [[UITextField alloc]initWithFrame:CGRectMake(90, 290, 240, 40)];
    [Password setDelegate:self];//设置代理为self
    Password.textColor = [UIColor blackColor];
    Password.backgroundColor = [self colorWithHexString:@"FFFFCC" alpha:0.5];
    Password.font = [UIFont fontWithName:@"OriyaSangamMN-Bold" size:18.0f];
    [Password setBorderStyle:(UITextBorderStyleRoundedRect)];
    Password.clearButtonMode = UITextFieldViewModeAlways;
    //Password.placeholder = @"密码不得少于8位";
    NSMutableAttributedString *Pword = [[NSMutableAttributedString alloc]initWithString:@"密码不得少于8位" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    Password.attributedPlaceholder = Pword;
    Password.secureTextEntry = YES;
    [self.view addSubview:Password];
    
    UIImageView *User = [[UIImageView alloc]initWithFrame:CGRectMake(145, 140, 85, 80)];
    User.image = [UIImage imageNamed:@"touxiang.png"];
    [self.view addSubview:User];
    
    UIButton *login = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    login.frame = CGRectMake(121, 400, 130, 40);
    login.layer.cornerRadius = 20.0;//设置登陆按钮的边角弧度
//    login.backgroundColor = [self colorWithHexString:@"87CEFA" alpha:1.0f];//登陆按钮背景颜色：浅蓝色
    login.backgroundColor = [self colorWithHexString:@"F2C200" alpha:1.0f];//登陆按钮背景颜色：浅蓝色
    [login.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [login.layer setBorderWidth:2];
    [login.layer setBorderColor:[self colorWithHexString:@"666666" alpha:1.0f].CGColor];
    
    [login setTitle:@"下一步" forState:(UIControlStateNormal)];
    [login setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [login setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
    [self.view addSubview:login];
    [login addTarget:self action:@selector(login_click) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:self];
}

- (void)login_click{
    if(Username.text.length!=0 && Email_address.text.length!=0 && Password.text.length>=8 ){
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功，即将自动登录..." preferredStyle:(UIAlertControllerStyleActionSheet)];
        alertView.view.backgroundColor = [UIColor whiteColor];
        alertView.view.tintColor = [UIColor blackColor];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"注册成功！");
            User_ViewController * user = [[User_ViewController alloc]init];
            [self.navigationController pushViewController:user animated:YES];//注册成功，自动登录进入用户主页
            user.username = self->Username.text;
            user.state = logged_in;
            user.navigationItem.hidesBackButton = YES;//隐藏导航栏的返回按钮
        }];
        [alertView addAction:sure];
        [self presentViewController:alertView animated:YES completion:nil];

        

    }
    else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败，请重试！" preferredStyle:(UIAlertControllerStyleActionSheet)];
        alertView.view.backgroundColor = [UIColor whiteColor];
        alertView.view.tintColor = [UIColor blackColor];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:sure];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}
@end
