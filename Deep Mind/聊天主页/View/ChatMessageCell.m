//
//  ChatMessageCell.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "ChatMessageCell.h"

@interface ChatMessageCell()
@property (strong, nonatomic)NSLayoutConstraint *leadingConstraint;
@property (strong, nonatomic)NSLayoutConstraint *trailingConstraint;

@end

@implementation ChatMessageCell

- (void)setChatmessage:(ChatMessage *)chatmessage{
    self.bubbleBackgroundView.backgroundColor = chatmessage.isComing ? UIColor.whiteColor : [UIColor colorWithRed:110/255.f green:182/255.f blue:110/255.f alpha:1];
    self.messageLabel.textColor = chatmessage.isComing ? UIColor.blackColor : UIColor.whiteColor;
    self.messageLabel.text = chatmessage.text;
    if (chatmessage.isComing) {
        self.trailingConstraint.active = NO;
        self.leadingConstraint.active = YES;
    }else{
        self.leadingConstraint.active = NO;
        self.trailingConstraint.active = YES;
    }
    _chatmessage = chatmessage;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        [self initCell];
    }
    return self;
}

- (void)initCell {
    self.messageLabel = ({
        UILabel *label = [UILabel new];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = @"Show Message Text Here Show Message Text Here Show Message Text Here Show Message Text Here Show Message Text Here Show Message Text Here Show Message Text Here Show Message Text Here Show Message Text Here...";
        label.numberOfLines = 0;
        label;
    });
    
    self.bubbleBackgroundView = ({
        UIView *view = [UIView new];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.layer.cornerRadius = 8;
        view;
    });
    
    [self setupConstraint];

}

- (void)setupConstraint {
    [self addSubview:self.bubbleBackgroundView];
    [self addSubview: self.messageLabel];
    
    [self.messageLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:16].active = YES;
    self.leadingConstraint = [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:32];
    self.leadingConstraint.active = YES;
    self.trailingConstraint = [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-32];
//    [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
//    [self.messageLabel.widthAnchor constraintEqualToConstant:250].active = YES;
    [self.messageLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-32].active = YES;
    [self.messageLabel.widthAnchor constraintLessThanOrEqualToConstant:250].active = YES;
    
    [self.bubbleBackgroundView.topAnchor constraintEqualToAnchor:self.messageLabel.topAnchor constant:-16].active = YES;
    [self.bubbleBackgroundView.leadingAnchor constraintEqualToAnchor:self.messageLabel.leadingAnchor constant:-16].active = YES;
    [self.bubbleBackgroundView.trailingAnchor constraintEqualToAnchor:self.messageLabel.trailingAnchor constant:16].active = YES;
    [self.bubbleBackgroundView.bottomAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor constant:16].active = YES;
}

@end
