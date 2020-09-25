//
//  Register_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Register_ViewController : UIViewController<UITextFieldDelegate>
{
    UIButton *login;
    UILabel *username;
    UITextField *Username;
    UILabel *userpsw;
    UITextField *Userpsw;
}
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *password;

@end

NS_ASSUME_NONNULL_END
