//
//  Login_ViewController.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Login_ViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    UITextField *Username;
    UITextField *Password;
    UITextField *Email_address;
}

@end

NS_ASSUME_NONNULL_END
