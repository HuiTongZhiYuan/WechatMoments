//
//  ContactsModel.m
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "ContactsModel.h"

@implementation ContactsModel


- (instancetype)initWithName:(NSString *)nameT userHeadUrl:(NSString *)userHeadUrlTemp
{
    self = [super init];
    if (self) {
        self.name = FLString(nameT, @"LMY");
        self.userHeadUrl = FLString(userHeadUrlTemp, @"");
    }
    return self;
}

- (NSString *)getName
{
    return _name;
}
@end
