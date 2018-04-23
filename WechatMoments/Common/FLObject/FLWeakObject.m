//
//  FLWeakObject.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "FLWeakObject.h"

@implementation FLWeakObject
+ (FLWeakObject *)weakObj:(id)obj
{
    FLWeakObject * weakobj = [[FLWeakObject alloc] init];
    weakobj.obj = obj;
    return weakobj;
}
@end
