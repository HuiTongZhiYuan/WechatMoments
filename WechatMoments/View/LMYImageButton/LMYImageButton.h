//
//  LMYImageButton.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LMYImageButtonDelegate <NSObject>
- (void)imageButtonClick:(NSInteger)index;
@end





@interface LMYImageButton : UIView

@property(nonatomic,weak)id<LMYImageButtonDelegate>delegate;


- (void)setImageWithUrl:(NSString *)urlStr tag:(NSInteger )tag;

- (void)sizeChangeed;

@end
