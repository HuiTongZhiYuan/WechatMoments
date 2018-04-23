//
//  FLWaitingView.h
//  Common
//
//  Created by lmy on 2017/5/9.
//  Copyright © 2017年 oiio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FLWaitingViewModeLoopDiagram, // 环形
    FLWaitingViewModePieDiagram // 饼型
} FLWaitingViewMode;

#define kIsFullWidthForLandScape YES //是否在横屏的时候直接满宽度，而不是满高度，一般是在有长图需求的时候设置为YES
// 图片下载进度指示进度显示样式（HZWaitingViewModeLoopDiagram 环形，HZWaitingViewModePieDiagram 饼型）
#define FLWaitingViewProgressMode FLWaitingViewModeLoopDiagram
#define kMinZoomScale 1.0f
#define kMaxZoomScale 2.0f

// 图片下载进度指示器背景色
#define FLWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

// 图片下载进度指示器内部控件间的间距
#define FLWaitingViewItemMargin 10

@interface FLWaitingView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) int mode;

@end
