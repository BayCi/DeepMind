//
//  Date_extension.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/26.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Date_extension.h"

@implementation NSDate(extension)
+ (NSDate*)dateFromCustomString: (NSString*) customString{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/yyyy";
    return [formatter dateFromString:customString];
}

@end
