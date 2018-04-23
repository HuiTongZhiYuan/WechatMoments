//
//  ContactsModel.h
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

/*
联系人信息
 */
#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject


@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * userHeadUrl;

- (instancetype)initWithName:(NSString *)nameT userHeadUrl:(NSString *)userHeadUrlTemp;

- (NSString *)getName;
@end
