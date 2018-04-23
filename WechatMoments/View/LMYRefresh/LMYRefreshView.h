//
//  LMYRefreshView.h
//  TestUpDownLoading
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, LMYRefreshState) {

    LMYRefreshStateNormal = 1,//正常状态

    LMYRefreshStatePulling,//松开即可刷新

    LMYRefreshStateRefreshing,//刷新中

    LMYRefreshStateRefreshed,//刷新结束

    LMYRefreshStateNoMoreData //没有更多
};



//刷新回调
typedef void (^LMYRefreshBeginRefreshingBlock)(void);


// 运行时objc_msgSend
#define LMYRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define LMYRefreshMsgTarget(target) (__bridge void *)(target)



@interface LMYRefreshView : UIView


@property (weak, nonatomic) UIScrollView *scrollView;

@property (copy, nonatomic) LMYRefreshBeginRefreshingBlock beginBlock;

@property (weak, nonatomic) id refreshingTarget;
@property (assign, nonatomic) SEL refreshingAction;

@end
