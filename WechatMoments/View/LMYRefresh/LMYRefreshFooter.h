//
//  LMYRefreshFooter.h
//  TestUpDownLoading
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMYRefreshView.h"


@interface LMYRefreshFooter : LMYRefreshView

@property(nonatomic,assign)LMYRefreshState state;
@property(nonatomic,assign)BOOL isAutoLoading;

- (instancetype)initWithFrame:(CGRect)frame target:(id)target refreshingAction:(SEL)action;

@end
