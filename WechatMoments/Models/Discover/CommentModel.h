//
//  CommentModel.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject


@property(nonatomic,copy)NSString * content;

@property(nonatomic,copy)NSString * sender_avatar;
@property(nonatomic,copy)NSString * sender_nick;
@property(nonatomic,copy)NSString * sender_username;

@property(nonatomic,assign)CGFloat height;

//格式化数据
+ (void)formatArray:(NSArray *)array addArray:(NSMutableArray *)mArray;

@end
