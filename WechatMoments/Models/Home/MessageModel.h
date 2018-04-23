//
//  MessageModel.h
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

/*
 消息类型model
 */


#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * userHeadUrl;
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign) NSInteger unreadCount;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
