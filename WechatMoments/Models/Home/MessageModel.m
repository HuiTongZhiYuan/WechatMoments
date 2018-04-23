//
//  MessageModel.m
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel





- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (dic) {
            self.name = FLString(dic[@"name"], @"");
            self.userHeadUrl = FLString(dic[@"userHeadUrl"], @"");
            self.msg = FLString(dic[@"msg"], @"");
            self.time = FLString(dic[@"time"], @"").doubleValue;
            self.unreadCount = FLString(dic[@"unreadCount"], @"").integerValue;
        }else{

            self.name = @"";
            self.userHeadUrl = @"";
            self.msg = @"";
            self.time = 0;
            self.unreadCount = 0;
        }
    }
    return self;
}
@end
