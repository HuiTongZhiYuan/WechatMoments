//
//  LMYToastManager.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//




#import "LMYLoadingCircleAnimationView.h"

@interface LMYToastModel : NSObject
@property (nonatomic, assign) SAHudType type;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) BOOL autoDismiss;
@property (nonatomic, assign) SAHudPosition position;
@property (nonatomic, assign) int interval;

@end

@implementation LMYToastModel

@end


#import "LMYToastManager.h"


@interface LMYToastManager ()<MBProgressHUDDelegate>
@property (nonatomic, strong) NSMutableArray *toastAry;

@end

@implementation LMYToastManager
+ (LMYToastManager *)manager {
    static LMYToastManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LMYToastManager alloc]init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.toastAry = [[NSMutableArray alloc]init];
    }
    return self;
}

//  Type_Loading与其他Type的区别，当类型不同立刻dismiss然后展示下一个type  ->(Type_Loading 没有文字)
- (void)addSAToast:(SAHudType)type
               msg:(NSString *)msg
       autoDismiss:(BOOL)autoDismiss
          position:(SAHudPosition)position
          interval:(int)interval
{
    LMYToastModel *model = [[LMYToastModel alloc]init];
    model.type = type;
    model.msg = msg;
    model.autoDismiss = autoDismiss;
    model.position = position;
    model.interval = interval;
    
    if (self.toastAry.count == 0) {
        [self.toastAry addObject:model];
        [self showSAToastWith:self.toastAry[0]];
    }
    else {
        LMYToastModel *currentModel;
        if (self.toastAry.count > 3) {  // 数组内最多能有3条数据->数据太多造成等待时间过长
            return;
        }
        else if (self.toastAry.count > 1){
            currentModel = [self.toastAry lastObject];
        }
        else {
            currentModel = self.toastAry[0];
        }
        
        // 暂时只区分 是否是 Type_Loading(没有文字提示)
        if (currentModel.type == type) {
            if (type != Type_Loading  && ![currentModel.msg isEqualToString:msg]) {
                [self.toastAry addObject:model];
            }
        }
        else { //
            
            NSInteger count = self.toastAry.count;
            if (count > 1) {
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, (count - 1))];
                [self.toastAry removeObjectsAtIndexes:indexSet];
            }
            [self.toastAry addObject:model];
            [MBProgressHUD dismissSAToast];
        }
    }
}

- (void)showSAToastWith:(LMYToastModel *)model
{
    SAHudType type = model.type;
    NSString *msg = model.msg;
    BOOL autoDismiss = model.autoDismiss;
    SAHudPosition position = model.position;
    int interval = model.interval;
    
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    hud.delegate = self;
    hud.detailsLabel.text = msg;
    hud.detailsLabel.font = [UIFont systemFontOfSize:17];
    hud.margin = 10;
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.alpha = 0.75;
    
    if (position == Position_Buttom) {
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    }
    
    if (autoDismiss) {
        [hud hideAnimated:YES afterDelay:interval];
    }
    
    switch (type) {
        case Type_Msg:
            if (![hud.detailsLabel.text length]) {
                hud.detailsLabel.text = @"请求失败";
            }
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabel.textColor = [UIColor whiteColor];
            break;
            
        case Type_Loading:
        {
            LMYLoadingCircleAnimationView *loadingView = [LMYLoadingCircleAnimationView install];
            hud.customView = loadingView;
            hud.mode = MBProgressHUDModeCustomView;
            
            hud.detailsLabel.text = @""; // 默认Type_Loading 没有文字提示
            hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.bezelView.color = [UIColor clearColor];//正方形背景
            hud.bezelView.alpha = 1.0f;
            hud.contentColor = [UIColor whiteColor];//圆形背景
        }
            break;
        case Type_FeedBackSuccess:
        {
            
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            
            NSString *bundlePath = [bundle pathForResource:@"customTotast" ofType:@"bundle"];
            NSString *imgPath= [bundlePath stringByAppendingPathComponent:@"feedsuccess.png"];
            
            
            UIImageView *feedImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imgPath]];
            hud.detailsLabel.text = @"感谢你的反馈";
            hud.customView = feedImage;
            hud.mode = MBProgressHUDModeCustomView;
            hud.detailsLabel.textColor = [UIColor whiteColor];
            hud.minSize = CGSizeMake(132, 117);
            /**
             *
             */
        }
            break;
        case Type_Success:
            if (![hud.detailsLabel.text length]) {
                hud.detailsLabel.text = @"请求成功";
            }
            hud.mode = MBProgressHUDModeCustomView;
            
            /**
             *
             */
            break;
            
        case Type_Error:
            if (![hud.detailsLabel.text length]) {
                hud.detailsLabel.text = @"请求失败";
            }
            hud.mode = MBProgressHUDModeCustomView;
            hud.detailsLabel.textColor = [UIColor whiteColor];
            /**
             *
             */
            break;
            
            
        default:
            break;
    }
    [hud updateConstraintsIfNeeded];
    //    hud.removeFromSuperViewOnHide = YES;
}


#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.toastAry.count > 1) {   // >1
        [self.toastAry removeObjectAtIndex:0];
        [self showSAToastWith:self.toastAry[0]];
    }
    else if (self.toastAry.count > 0) {     // ==1
        [self.toastAry removeObjectAtIndex:0];
    }
}

@end
