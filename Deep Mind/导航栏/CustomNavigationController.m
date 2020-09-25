//
//  CustomNavigationController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/10/9.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {//非根视图
        viewController.hidesBottomBarWhenPushed =YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
