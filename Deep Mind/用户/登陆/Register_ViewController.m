//
//  Register_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Register_ViewController.h"
#import "User_ViewController.h"
#import "Login_ViewController.h"
@interface Register_ViewController ()

@end

@implementation Register_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, 374, 553)];//登陆背景图
    background.image = [UIImage imageNamed:@"background_login.png"];
    [self.view addSubview:background];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];//返回按钮
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];//返回按钮颜色


    UIImageView *user = [[UIImageView alloc]initWithFrame:CGRectMake(40, 175, 30, 30)];
    user.image = [UIImage imageNamed:@"user.png"];
    [self.view addSubview:user];
    
    Username = [[UITextField alloc]initWithFrame:CGRectMake(90, 170, 240, 40)];//用户名的文本域
    [Username setDelegate:self];//设置代理为self
    Username.font = [UIFont fontWithName:@"OriyaSangamMN-Bold" size:18.0f];
    Username.backgroundColor = [self colorWithHexString:@"FFFFCC" alpha:0.5];
    [Username setBorderStyle:(UITextBorderStyleRoundedRect)];
    Username.clearButtonMode = UITextFieldViewModeAlways;
    Username.alpha = 0.5;//设置用户名的文本域透明度
    Username.returnKeyType = UIReturnKeyDone;
    //Username.placeholder = @"用户名或邮箱地址";
    NSMutableAttributedString *Uname = [[NSMutableAttributedString alloc]initWithString:@"用户名或邮箱地址" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    Username.attributedPlaceholder = Uname;
    Username.text = _username;
    Username.textColor = [UIColor blackColor];
    [self.view addSubview:Username];
    
    UIImageView *password = [[UIImageView alloc]initWithFrame:CGRectMake(40, 235, 30, 30)];
    password.image = [UIImage imageNamed:@"password.png"];
    [self.view addSubview:password];
    
    Userpsw = [[UITextField alloc]initWithFrame:CGRectMake(90, 230, 240, 40)];//用户密码的文本域
    [Userpsw setDelegate:self];//设置代理为self
    Userpsw.font = [UIFont fontWithName:@"OriyaSangamMN-Bold" size:18.0f];
    Userpsw.backgroundColor = [self colorWithHexString:@"FFFFCC" alpha:0.5];
    Userpsw.textColor = [UIColor blackColor];
    [Userpsw setBorderStyle:(UITextBorderStyleRoundedRect)];
    Userpsw.clearButtonMode = UITextFieldViewModeAlways;
    Userpsw.alpha = 0.5;//设置用户密码的文本域透明度
    //Userpsw.placeholder = @"请输入密码";
    NSMutableAttributedString *Pword = [[NSMutableAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    Userpsw.attributedPlaceholder = Pword;
    Userpsw.secureTextEntry = YES;
    [self.view addSubview:Userpsw];
    
    login = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//注册按钮
    login.frame = CGRectMake(40, 340, 125, 45);
    login.layer.cornerRadius = 20.0;
    [login setFont:[UIFont systemFontOfSize:18.0f]];
    //login.backgroundColor = [self colorWithHexString:@"87CEFA" alpha:1.0f];//注册按钮背景颜色：浅蓝色
    login.backgroundColor = [UIColor whiteColor];//注册按钮背景颜色：白色
    
    [login.layer setMasksToBounds:YES];//设置注册按钮外边框颜色
    [login.layer setBorderWidth:2];
    [login.layer setBorderColor:[self colorWithHexString:@"666666" alpha:1.0f].CGColor];
    
    [login setTitle:@"注册" forState:(UIControlStateNormal)];
    [login setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [login setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
    [self.view addSubview:login];
    [login addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *enter = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//登陆按钮
    enter.frame = CGRectMake(205, 340, 125, 45);
    enter.layer.cornerRadius = 20.0;//设置登陆按钮的边角弧度
    [enter setFont:[UIFont systemFontOfSize:18.0f]];
    enter.backgroundColor = [self colorWithHexString:@"F2C200" alpha:1.0f];//登陆按钮背景颜色：浅蓝色
    
    [enter.layer setMasksToBounds:YES];//设置登录按钮外边框颜色
    [enter.layer setBorderWidth:2];
    [enter.layer setBorderColor:[self colorWithHexString:@"666666" alpha:1.0f].CGColor];
    
    [enter setTitle:@"登陆" forState:(UIControlStateNormal)];
    [enter setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [enter setTitleColor:[UIColor blueColor] forState:(UIControlStateSelected)];
    [self.view addSubview:enter];
    [enter addTarget:self action:@selector(enter_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:Username.text forKey:@"value"];
    [defaults synchronize];
}

- (void)back{
    User_ViewController *user = [[self.navigationController viewControllers]objectAtIndex:1];
    [self.navigationController popViewControllerAnimated:self];
}

- (void)enter_click
{
    if (Username.text.length!=0 && Userpsw.text.length>=8 && Userpsw.text == _password && Username.text == _username){
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆成功，即将自动登录..." preferredStyle:(UIAlertControllerStyleActionSheet)];
            alertView.view.tintColor = [UIColor blackColor];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                User_ViewController * user = [[User_ViewController alloc]init];
                [self.navigationController pushViewController:user animated:YES];//登陆成功，进入用户主页
                user.username = self->Username.text;
                user.navigationItem.hidesBackButton = YES;//隐藏导航栏的返回按钮
            }];
            [alertView addAction:sure];
            [self presentViewController:alertView animated:YES completion:nil];

        }
        else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆失败，用户名不存在或密码错误，请重试！" preferredStyle:(UIAlertControllerStyleActionSheet)];
            alertView.view.tintColor = [UIColor blackColor];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:sure];
            [self presentViewController:alertView animated:YES completion:nil];
        }
    
}

- (void)click{
    Login_ViewController *Lv = [[Login_ViewController alloc]init];
    [self.navigationController pushViewController:Lv animated:YES];
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
