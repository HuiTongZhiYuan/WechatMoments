//
//  LMYRefreshHeader.h
//  TestUpDownLoading
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMYRefreshView.h"

@interface LMYRefreshHeader : LMYRefreshView

@property(nonatomic,assign)LMYRefreshState state;

- (instancetype)initWithFrame:(CGRect)frame target:(id)target refreshingAction:(SEL)action;

@end
