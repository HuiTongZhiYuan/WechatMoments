//
//  UIViewController+MJPopupViewController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "UIViewController+MJPopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MJPopupBackgroundView.h"
#import <objc/runtime.h>

#define kPopupModalAnimationDuration 0.35
#define kMJPopupViewController                  @"kMJPopupViewController"
#define kMJPopupBackgroundView                  @"kMJPopupBackgroundView"
#define kMJPopupShowStatusBar                   @"kMJPopupShowStatusBar"
#define KMJPopupRemoveBackgroundEvent           @"KMJPopupRemoveBackgroundEvent"
#define KMJPopupNavigationGuesture              @"KMJPopupNavigationGuesture"
#define KMJHasPopup                             @"KMJHasPopup"

#define kMJSourceViewTag 23941
#define kMJPopupViewTag 23942
#define kMJOverlayViewTag 23945

@interface UIViewController (MJPopupViewControllerPrivate)
- (UIView*)topView;
- (void)presentPopupView:(UIView*)popupView;
@end

static NSString *MJPopupViewDismissedKey = @"MJPopupViewDismissed";

////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

@implementation UIViewController (MJPopupViewController)

static void * const keypath = (void*)&keypath;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (BOOL)prefersStatusBarHidden
{
    NSNumber *number = objc_getAssociatedObject(self, kMJPopupShowStatusBar);
    
    return [number boolValue];
}





#pragma clang diagnostic pop

- (UIViewController*)mj_popupViewController {
    return objc_getAssociatedObject(self, kMJPopupViewController);
}

- (void)setMj_popupViewController:(UIViewController *)mj_popupViewController {
    objc_setAssociatedObject(self, kMJPopupViewController, mj_popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (MJPopupBackgroundView*)mj_popupBackgroundView {
    return objc_getAssociatedObject(self, kMJPopupBackgroundView);
}

- (void)setMj_popupBackgroundView:(MJPopupBackgroundView *)mj_popupBackgroundView {
    objc_setAssociatedObject(self, kMJPopupBackgroundView, mj_popupBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}



- (BOOL)removeBackgroundEvent {
    return [objc_getAssociatedObject(self, KMJPopupRemoveBackgroundEvent) boolValue];
}


- (void)setRemoveBackgroundEvent:(BOOL)removeBackgroundEvent {
    objc_setAssociatedObject(self, KMJPopupRemoveBackgroundEvent, [NSNumber numberWithBool:removeBackgroundEvent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)navigationGuestureState
{
    id obj = objc_getAssociatedObject(self, KMJPopupNavigationGuesture);
    if (!obj) {
        return YES;
    }else{
        return [obj boolValue];
    }
    
}

- (void)setNavigationGuestureState:(BOOL)guestureState
{
    objc_setAssociatedObject(self, KMJPopupNavigationGuesture, [NSNumber numberWithBool:guestureState], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hasPopup
{
    return [objc_getAssociatedObject(self, KMJHasPopup) boolValue];
}

- (void)setHasPopup:(BOOL)hasPopup
{
    objc_setAssociatedObject(self, KMJHasPopup, [NSNumber numberWithBool:hasPopup], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}








#pragma mark -
#pragma mark - present VC

//1)animationType
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType
{
    [self presentPopupViewController:popupViewController animationType:animationType hideStatusBar:YES dismissed:nil];
}

//2)animationType,hideStatusBar
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType hideStatusBar:(BOOL)hide
{
    [self presentPopupViewController:popupViewController animationType:animationType hideStatusBar:hide dismissed:nil];
}

//3)animationType,dismissed
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType dismissed:(void(^)(void))dismissed
{
    [self presentPopupViewController:popupViewController animationType:animationType hideStatusBar:YES dismissed:dismissed];
}

//4)animationType,hideStatusBar,dismissed
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType hideStatusBar:(BOOL)hide dismissed:(void(^)(void))dismissed
{
    if ([self hasPopup]) {
        return;
    }
    [self setHasPopup:YES];
    self.mj_popupViewController = popupViewController;
    objc_setAssociatedObject(self, kMJPopupShowStatusBar, [NSNumber numberWithBool:hide], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    [self presentPopupView:popupViewController.view animationType:animationType  dismissed:dismissed];
}

//5)animationType,hideStatusBar,dismissed,showStatusBarBeforeDismiss - for iOS 9.2 statusBar show
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType hideStatusBar:(BOOL)hide showStatusBarBeforeDismiss:(BOOL)showBeforeDismiss dismissed:(void(^)(void))dismissed
{
    if ([self hasPopup]) {
        return;
    }
    [self setHasPopup:YES];
    self.mj_popupViewController = popupViewController;
    objc_setAssociatedObject(self, kMJPopupShowStatusBar, [NSNumber numberWithBool:hide], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    [self presentPopupView:popupViewController.view
             animationType:animationType
showStatusBarBeforeDismiss:showBeforeDismiss
                 dismissed:dismissed];
}







#pragma mark -
#pragma mark - dismiss
- (void)dismissPopupViewControllerWithanimationType:(MJPopupViewAnimation)animationType
{
    if (![self hasPopup]) {
        return;
    }
    
    [self setHasPopup:NO];
    
    objc_setAssociatedObject(self, kMJPopupShowStatusBar, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        BOOL state = [self navigationGuestureState];
        self.navigationController.interactivePopGestureRecognizer.enabled = state;
    }
    
    
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kMJPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kMJOverlayViewTag];
    
    switch (animationType) {
        case MJPopupViewAnimationSlideBottomTop:
        case MJPopupViewAnimationSlideBottomBottom:
        case MJPopupViewAnimationSlideTopTop:
        case MJPopupViewAnimationSlideTopBottom:
        case MJPopupViewAnimationSlideLeftLeft:
        case MJPopupViewAnimationSlideLeftRight:
        case MJPopupViewAnimationSlideRightLeft:
        case MJPopupViewAnimationSlideRightRight:
        case MJPopupViewAnimationSlideBottomBottom_ORIGINAL:
            [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
            
        case MJPopupViewAnimationNone:
            [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView animation:NO];
            break;
            
        default:
            [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
}



////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(MJPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    sourceView.tag = kMJSourceViewTag;
    
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kMJPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
    popupView.layer.shouldRasterize = YES;
    popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kMJOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    self.mj_popupBackgroundView = [[MJPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    self.mj_popupBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mj_popupBackgroundView.backgroundColor = [UIColor clearColor];
    self.mj_popupBackgroundView.alpha = 0.0f;
    [overlayView addSubview:self.mj_popupBackgroundView];
    
    // Make the Background Clickable
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    [overlayView addSubview:dismissButton];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    if (!self.removeBackgroundEvent) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        BOOL state = self.navigationController.interactivePopGestureRecognizer.enabled;
        [self setNavigationGuestureState:state];
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    switch (animationType) {
        case MJPopupViewAnimationSlideBottomTop:
        case MJPopupViewAnimationSlideBottomBottom:
        case MJPopupViewAnimationSlideTopTop:
        case MJPopupViewAnimationSlideTopBottom:
        case MJPopupViewAnimationSlideLeftLeft:
        case MJPopupViewAnimationSlideLeftRight:
        case MJPopupViewAnimationSlideRightLeft:
        case MJPopupViewAnimationSlideRightRight:
        case MJPopupViewAnimationSlideBottomBottom_ORIGINAL:
            dismissButton.tag = animationType;
            [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
            
        case MJPopupViewAnimationNone:
            dismissButton.tag = animationType;
            [self showViewIn:popupView sourceView:sourceView overlayView:overlayView];
            break;
            
        default:
            dismissButton.tag = MJPopupViewAnimationFade;
            [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
}

- (void)presentPopupView:(UIView*)popupView animationType:(MJPopupViewAnimation)animationType dismissed:(void(^)(void))dismissed
{
    [self presentPopupView:popupView animationType:animationType];
    [self setDismissedCallback:dismissed];
}

//new for show status bar in iOS 9.2
- (void)presentPopupView:(UIView*)popupView animationType:(MJPopupViewAnimation)animationType showStatusBarBeforeDismiss:(BOOL)showStatusBarBeforeDismiss dismissed:(void(^)(void))dismissed
{
    //1)显示动画
    [self presentPopupView:popupView animationType:animationType];
    
    //2）设置statusBar
    if (showStatusBarBeforeDismiss) {
        objc_setAssociatedObject(self, kMJPopupShowStatusBar, [NSNumber numberWithBool:NO], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //3)回调dismiss
    [self setDismissedCallback:dismissed];
}







-(UIView*)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

- (void)dismissPopupViewControllerWithanimation:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton* dismissButton = sender;
        switch (dismissButton.tag) {
            case MJPopupViewAnimationSlideBottomTop:
            case MJPopupViewAnimationSlideBottomBottom:
            case MJPopupViewAnimationSlideTopTop:
            case MJPopupViewAnimationSlideTopBottom:
            case MJPopupViewAnimationSlideLeftLeft:
            case MJPopupViewAnimationSlideLeftRight:
            case MJPopupViewAnimationSlideRightLeft:
            case MJPopupViewAnimationSlideRightRight:
            case MJPopupViewAnimationSlideBottomBottom_ORIGINAL:
                [self dismissPopupViewControllerWithanimationType:(int)dismissButton.tag];
                break;
            default:
                [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
                break;
        }
    } else {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    }
}

//////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Animations

#pragma mark --- Slide

- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(MJPopupViewAnimation)animationType
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    switch (animationType) {
        case MJPopupViewAnimationSlideBottomTop:
        case MJPopupViewAnimationSlideBottomBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        sourceSize.height,
                                        popupSize.width,
                                        popupSize.height);
            
            break;
        case MJPopupViewAnimationSlideLeftLeft:
        case MJPopupViewAnimationSlideLeftRight:
            popupStartRect = CGRectMake(-sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        case MJPopupViewAnimationSlideTopTop:
        case MJPopupViewAnimationSlideTopBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        -popupSize.height,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        case MJPopupViewAnimationSlideBottomBottom_ORIGINAL:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width),
                                        sourceSize.height,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        default:
            popupStartRect = CGRectMake(sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    if (animationType == MJPopupViewAnimationSlideBottomBottom_ORIGINAL) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width),
                                  (sourceSize.height - popupSize.height),
                                  popupSize.width,
                                  popupSize.height);
    }
    
    
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    
    if (animationType == MJPopupViewAnimationSlideBottomBottom_ORIGINAL) {
        [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.mj_popupViewController viewWillAppear:NO];
            self.mj_popupBackgroundView.alpha = 1.0f;
            popupView.frame = popupEndRect;
        } completion:^(BOOL finished) {
            [self.mj_popupViewController viewDidAppear:NO];
        }];
    }else{
        [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.mj_popupViewController viewWillAppear:NO];
            self.mj_popupBackgroundView.alpha = 1.0f;
            popupView.frame = popupEndRect;
        } completion:^(BOOL finished) {
            [self.mj_popupViewController viewDidAppear:NO];
        }];
    }
    
    
}

- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(MJPopupViewAnimation)animationType
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    switch (animationType) {
        case MJPopupViewAnimationSlideBottomTop:
        case MJPopupViewAnimationSlideTopTop:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      -popupSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case MJPopupViewAnimationSlideBottomBottom:
        case MJPopupViewAnimationSlideTopBottom:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      sourceSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
            
        case MJPopupViewAnimationSlideBottomBottom_ORIGINAL:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width),
                                      sourceSize.height,
                                      popupSize.width,
                                      popupSize.height);
            
            break;
        case MJPopupViewAnimationSlideLeftRight:
        case MJPopupViewAnimationSlideRightRight:
            popupEndRect = CGRectMake(sourceSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
        default:
            popupEndRect = CGRectMake(-popupSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.mj_popupViewController viewWillDisappear:NO];
        popupView.frame = popupEndRect;
        self.mj_popupBackgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.mj_popupViewController viewDidDisappear:NO];
        self.mj_popupViewController = nil;
        
        id dismissed = [self dismissedCallback];
        if (dismissed != nil)
        {
            ((void(^)(void))dismissed)();
            [self setDismissedCallback:nil];
        }
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.mj_popupViewController viewWillAppear:NO];
        self.mj_popupBackgroundView.alpha = 0.5f;
        popupView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.mj_popupViewController viewDidAppear:NO];
    }];
}


- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView animation:(BOOL)animation
{
    if (animation) {
        [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
            [self.mj_popupViewController viewWillDisappear:NO];
            self.mj_popupBackgroundView.alpha = 0.0f;
            popupView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [popupView removeFromSuperview];
            [overlayView removeFromSuperview];
            [self.mj_popupViewController viewDidDisappear:NO];
            self.mj_popupViewController = nil;
            
            id dismissed = [self dismissedCallback];
            if (dismissed != nil)
            {
                ((void(^)(void))dismissed)();
                [self setDismissedCallback:nil];
            }
        }];
        
    }else{
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.mj_popupViewController viewDidDisappear:NO];
        self.mj_popupViewController = nil;
        
        id dismissed = [self dismissedCallback];
        if (dismissed != nil)
        {
            ((void(^)(void))dismissed)();
            [self setDismissedCallback:nil];
        }
        
    }
}


- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.mj_popupViewController viewWillDisappear:NO];
        self.mj_popupBackgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.mj_popupViewController viewDidDisappear:NO];
        self.mj_popupViewController = nil;
        
        id dismissed = [self dismissedCallback];
        if (dismissed != nil)
        {
            ((void(^)(void))dismissed)();
            [self setDismissedCallback:nil];
        }
    }];
}

#pragma mark --- Without animation
- (void)showViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 1.0f;
    
    [self.mj_popupViewController viewWillAppear:NO];
    self.mj_popupBackgroundView.alpha = 0.5f;
    popupView.alpha = 1.0f;
    [self.mj_popupViewController viewDidAppear:NO];
}

#pragma mark -
#pragma mark Category Accessors

#pragma mark --- Dismissed

- (void)setDismissedCallback:(void(^)(void))dismissed
{
    objc_setAssociatedObject(self, &MJPopupViewDismissedKey, dismissed, OBJC_ASSOCIATION_RETAIN);
}

- (void(^)(void))dismissedCallback
{
    return objc_getAssociatedObject(self, &MJPopupViewDismissedKey);
}

@end
