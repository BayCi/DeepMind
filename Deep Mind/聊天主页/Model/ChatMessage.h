//
//  ChatMessage.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatMessage : NSObject
@property (strong, nonatomic) NSString *text;
@property (nonatomic) BOOL isComing;
@property (nonatomic, strong) NSDate *date;
- (id)initWithText: (NSString *)text isComing: (BOOL)isComing date: (NSDate*)date;
@end

NS_ASSUME_NONNULL_END
