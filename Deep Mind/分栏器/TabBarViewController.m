//
//  TabBarViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/23.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "TabBarViewController.h"
#import "CustomNavigationController.h"
#import "User_ViewController.h"
#import "Want_ViewController.h"
#import "Statistics_ViewController.h"
#import "Record_ViewController.h"
#import "InformationChange_ViewController.h"
#import "MessagesViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];//设置底部分栏器的颜色
    //app启动页
    // 创建UIImageView，添加到界面
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    [self.view addSubview:imageView];

    // 创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
    UIImage *image1 = [UIImage imageNamed:@"pic1.png"];
    NSMutableArray *imgArray = [[NSMutableArray alloc]initWithObjects:image1, nil];
    for (int i=2; i<=67; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%d.png",i]];
        [imgArray addObject:image];
    }
    // 把存有UIImage的数组赋给动画图片数组 imageView.animationImages = imgArray;
    // 设置执行一次完整动画的时长
    imageView.animationImages = imgArray;
    imageView.animationDuration = 6*0.30;
    imageView.animationRepeatCount = 1;//动画重复次数 （0为重复播放）
    [imageView startAnimating];//开始播放动画
    //启动页结束
    
    MessagesViewController *view1 =[[MessagesViewController alloc]init];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"等等聊" image:[UIImage imageNamed:@"Home.png"] tag:101];
    view1.tabBarItem = item1;
    CustomNavigationController *navigationController1 = [[CustomNavigationController alloc]initWithRootViewController:view1];
    navigationController1.title = @"等等聊";
    
    Want_ViewController *view2 = [[Want_ViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"想要" image:[UIImage imageNamed:@"Want.png"] tag:101];
    view2.tabBarItem = item2;
    CustomNavigationController *navigationController2 = [[CustomNavigationController alloc]initWithRootViewController:view2];
    navigationController2.title = @"想要";
    
    Record_ViewController *view3 = [[Record_ViewController alloc]init];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"记录" image:[UIImage imageNamed:@"Record.png"] tag:101];
    view3.tabBarItem = item3;
    CustomNavigationController *navigationController3 = [[CustomNavigationController alloc]initWithRootViewController:view3];
    //[navigationController3.navigationBar setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 88)];
    navigationController3.title = @"记录";
    
    Statistics_ViewController *view4 = [[Statistics_ViewController alloc]init];
    UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"统计" image:[UIImage imageNamed:@"Statictics.png"] tag:101];
    view4.tabBarItem = item4;
    UINavigationController *navigationController4 = [[UINavigationController alloc]initWithRootViewController:view4];
    navigationController4.title = @"统计";
    
    User_ViewController *view5 = [[User_ViewController alloc]init];
    UITabBarItem *item5 = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"Me.png"] tag:101];
    view5.tabBarItem = item5;
    UINavigationController *navigationController5 = [[UINavigationController alloc]initWithRootViewController:view5];
    navigationController5.title = @"我的";

    
    
    NSArray *viewController = @[navigationController1,navigationController3,navigationController4,navigationController5];
    
    [self setViewControllers:viewController animated:NO];
}

    


@end
