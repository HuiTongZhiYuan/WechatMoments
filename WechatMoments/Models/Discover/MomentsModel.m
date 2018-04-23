//
//  MomentsModel.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentsModel.h"
#import "CommentModel.h"
#import "MomentsPostView.h"


@implementation MomentsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sender_avatar = @"";
        self.sender_nick = @"";
        self.sender_username = @"";
        
        self.content = @"";
        
        self.images = nil;
        self.comments = [[NSMutableArray alloc] init];
    }
    return self;
}



//格式化数据
+ (void)formatArray:(NSArray *)array addArray:(NSMutableArray *)mArray
{
    if (array && [array isKindOfClass:[NSArray class]] && array.count > 0)
    {
        for (int i =0; i<array.count; i++) {
            NSDictionary * dic = FLDictionary([array objectAtIndex:i], nil);
            if (dic) {
                NSDictionary * sender =FLDictionary([dic objectForKey:@"sender"], nil);
                if (sender) { //有人存在，代表正常帖子
                    
                    MomentsModel * tModel = [[MomentsModel alloc] init];
                    
                    tModel.sender_avatar = FLString([sender objectForKey:@"avatar"], @"");
                    tModel.sender_nick = FLString([sender objectForKey:@"nick"],@"");
                    tModel.sender_username = FLString([sender objectForKey:@"username"], @"");
                    
                    tModel.content = FLString([dic objectForKey:@"content"], @"");
                    
                    tModel.images = FLArray([dic objectForKey:@"images"], nil);
                    
                    NSArray * comments = FLArray([dic objectForKey:@"comments"], nil);
                    if (comments) {
                        [CommentModel formatArray:comments addArray:tModel.comments];
                    }
                    tModel.height = [MomentsPostView heightWithModel:tModel];
                    
                    [mArray addObject:tModel];
                }
            }
        }
    }
}
@end
