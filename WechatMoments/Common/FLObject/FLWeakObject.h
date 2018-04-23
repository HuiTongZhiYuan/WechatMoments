//
//  FLWeakObject.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLWeakObject : NSObject
+ (instancetype)weakObj:(id)obj;
@property (nonatomic,weak) id obj;

@end
