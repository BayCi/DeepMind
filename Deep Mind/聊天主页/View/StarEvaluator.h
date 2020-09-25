//
//  StarEvaluator.h
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/10/13.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarEvaluator;
@protocol StarEvaluatorDelegate <NSObject>

@optional
- (void)starEvaluator:(StarEvaluator *)evaluator currentValue:(float)value;

@end

@interface StarEvaluator : UIControl

@property (assign, nonatomic) BOOL animate;
@property (assign, nonatomic) id<StarEvaluatorDelegate>delegate;

@end
