//
//  ChatMessageCell.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"

@interface ChatMessageCell : UITableViewCell
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIView *bubbleBackgroundView;
@property (strong, nonatomic) ChatMessage *chatmessage;
@end
