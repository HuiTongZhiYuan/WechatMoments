//
//  Constants.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


#define FL_FONT(i) [UIFont systemFontOfSize:i]

#define SCREEN_WIDTH      [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT      [[UIScreen mainScreen] bounds].size.height


#define iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)

// 适配iPhoneX
#define X_TopHeight (iPhoneX ? 24.f : 0.f)
#define X_BottomHeight (iPhoneX ? 34.f : 0.f)//Tabbar距离底部的距离

// 适配iPhone X 状态栏高度
#define LMY_StatusBarHeight  (iPhoneX ? 44.f : 20.f)

// 适配iPhone X Tabbar高度
#define LMY_TabbarHeight (iPhoneX ? 83.f : 49.f)

// 适配iPhone X 导航栏高度
#define LMY_NavHeight (iPhoneX ? 88.f : 64.f)


#define CachesDirectoryPath  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]


//历史记录
#define SearchHistoryPath [NSString stringWithFormat:@"%@/SearchHistoryPath.plist",DocumentDirectoryPath]


#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define HEX(rgb) RGB((rgb) >> 16 & 0xff, (rgb) >> 8 & 0xff, (rgb)&0xff)

#define CHECK_VALID_STRING(__aString) (__aString && [__aString isKindOfClass:[NSString class]] && [__aString length])
#define CHECK_VALID_DATA(__aData) (__aData && [__aData isKindOfClass:[NSData class]] && [__aData length])
#define CHECK_VALID_NUMBER(__aNumber) (__aNumber && [__aNumber isKindOfClass:[NSNumber class]])
#define CHECK_VALID_ARRAY(__aArray) (__aArray && [__aArray isKindOfClass:[NSArray class]] && [__aArray count])
#define CHECK_VALID_DICTIONARY(__aDictionary) \
(__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]] && [__aDictionary count])
#define CHECK_VALID_SET(__aSet) (__aSet && [__aSet isKindOfClass:[NSSet class]] && [__aSet count])

#define CHECK_VALID_DELEGATE(__aDelegate, __aSelector) (__aDelegate && [__aDelegate respondsToSelector:__aSelector])
#define DEFAULT_STRING (@"")


#define L_FONT(i) [UIFont systemFontOfSize:i]

#define SCREEN_Equal_To_35INCH      (SCREEN_HEIGHT <= 480.0)
#define SCREEN_Equal_To_4INCH       (SCREEN_WIDTH >= 320.0 && SCREEN_HEIGHT <= 568.0)
#define SCREEN_Equal_To_47INCH      (SCREEN_WIDTH >= 375.0 && SCREEN_HEIGHT <= 667.0)
#define SCREEN_Equal_To_55INCH      (SCREEN_WIDTH >= 414.0)
#define SCREEN_Equal_To_58INCH      (SCREEN_WIDTH >= 375 && SCREEN_HEIGHT <= 812.0) //iPhone X





#define UIColorFromRGBA(c,a)                [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]
#define Color_CommonGreen         UIColorFromRGBA(0x40B393, 1)//统一绿色
#define Color_CommonBlue          UIColorFromRGBA(0x859bc8, 1)//统一的蓝色字体颜色
#define Color_BackgroundGray          UIColorFromRGBA(0xf1f0f3, 1)//统一的背景灰色
#define Color_BackgroundBlack          UIColorFromRGBA(0x333333, 1)//统一黑色
#define Color_CommonRed          HEX(0xED7367)//统一红色
#define Color_Line_Background          RGB(219,219,219)

#define RGB_153 RGB(153,153,153)
#define RGB_215 RGB(215,215,215)
#define RGB_255 RGB(255,255,255)
#define RGB_51 RGB(51,51,51)
#define RGB_102 RGB(102,102,102)
#define RGB_Line_Color RGB(219,219,219)

/// 文字颜色
/// #56585f
#define MH_MAIN_TEXT_COLOR_1 HEX(0xB2B2B2)
/// #9CA1B2
#define MH_MAIN_TEXT_COLOR_2 HEX(0x20DB1F)
/// #FE583E
#define MH_MAIN_TEXT_COLOR_3 HEX(0xFE583E)
/// #0ECCCA
#define MH_MAIN_TEXT_COLOR_4 HEX(0x0ECCCA)
/// #3C3E44
#define MH_MAIN_TEXT_COLOR_5 HEX(0x3C3E44)

#define MH_MAIN_TINTCOLOR [UIColor colorWithRed:(10 / 255.0) green:(193 / 255.0) blue:(42 / 255.0) alpha:1]
//视图的背景色
#define MH_MAIN_BACKGROUNDCOLOR HEX(0xEFEFF4)
//分割线颜色
#define MH_MAIN_LINE_COLOR_1 HEX(0xD9D8D9)


