//
//  ChatMessage.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage
-(id)initWithText: (NSString *)text isComing:(BOOL)isComing date:(NSDate *)date
{
    if (self = [super init]) {
        self.text = text;
        self.isComing = isComing;
        self.date = date;
    }
    return self;
}
@end
