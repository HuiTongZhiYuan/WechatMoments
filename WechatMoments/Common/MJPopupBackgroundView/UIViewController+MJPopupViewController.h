//
//  UIViewController+MJPopupViewController.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJPopupBackgroundView;

typedef enum {
    MJPopupViewAnimationNone = -1,
    MJPopupViewAnimationFade = 0,
    MJPopupViewAnimationSlideBottomTop = 1,
    MJPopupViewAnimationSlideBottomBottom,
    MJPopupViewAnimationSlideTopTop,
    MJPopupViewAnimationSlideTopBottom,
    MJPopupViewAnimationSlideLeftLeft,
    MJPopupViewAnimationSlideLeftRight,
    MJPopupViewAnimationSlideRightLeft,
    MJPopupViewAnimationSlideRightRight,
    MJPopupViewAnimationSlideBottomBottom_ORIGINAL,
} MJPopupViewAnimation;

@interface UIViewController (MJPopupViewController)

@property (nonatomic, retain) UIViewController *mj_popupViewController;
@property (nonatomic, retain) MJPopupBackgroundView *mj_popupBackgroundView;
@property (nonatomic, assign) BOOL removeBackgroundEvent;

//1)animationType
- (void)presentPopupViewController:(UIViewController*)popupViewController
                     animationType:(MJPopupViewAnimation)animationType;

//2)animationType,hideStatusBar
- (void)presentPopupViewController:(UIViewController*)popupViewController
                     animationType:(MJPopupViewAnimation)animationType
                     hideStatusBar:(BOOL)hide;

//3)animationType,dismissed
- (void)presentPopupViewController:(UIViewController*)popupViewController
                     animationType:(MJPopupViewAnimation)animationType
                         dismissed:(void(^)(void))dismissed;

//4)animationType,hideStatusBar,dismissed
- (void)presentPopupViewController:(UIViewController*)popupViewController
                     animationType:(MJPopupViewAnimation)animationType
                     hideStatusBar:(BOOL)hide
                         dismissed:(void(^)(void))dismissed;

//5)animationType,hideStatusBar,dismissed,showStatusBarBeforeDismiss
- (void)presentPopupViewController:(UIViewController*)popupViewController
                     animationType:(MJPopupViewAnimation)animationType
                     hideStatusBar:(BOOL)hide
        showStatusBarBeforeDismiss:(BOOL)showBeforeDismiss
                         dismissed:(void(^)(void))dismissed;


- (void)dismissPopupViewControllerWithanimationType:(MJPopupViewAnimation)animationType;

-(BOOL)hasPopup;
@end
