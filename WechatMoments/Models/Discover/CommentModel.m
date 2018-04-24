//
//  CommentModel.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.content = @"";

        self.landscapeHeight = 0;
        self.portraitHeight = 0;

        self.sender_avatar = @"";
        self.sender_nick = @"";
        self.sender_username = @"";
    }
    return self;
}

//格式化数据
+ (void)formatArray:(NSArray *)array addArray:(NSMutableArray *)mArray
{
    for (int i =0; i<array.count; i++) {
        NSDictionary * dic = FLDictionary([array objectAtIndex:i], nil);
        if (dic) {
            NSDictionary * sender =FLDictionary([dic objectForKey:@"sender"], nil);
            if (sender) { //有人存在，代表正常帖子
                
                CommentModel * comModel = [[CommentModel alloc] init];
                
                comModel.sender_avatar = FLString([sender objectForKey:@"avatar"], @"");
                comModel.sender_nick = FLString([sender objectForKey:@"nick"],@"");
                comModel.sender_username = FLString([sender objectForKey:@"username"], @"");
                
                comModel.content = FLString([dic objectForKey:@"content"], @"");
                
                [mArray addObject:comModel];
            }
        }
    }
}


- (CGFloat)modelHeight
{
    NSString * text = [NSString stringWithFormat:@"%@：%@",self.sender_nick,self.content];
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString: text];
    attributedStr.yy_color = RGB_51;
    attributedStr.yy_font = [UIFont systemFontOfSize:14];

    NSRange range = [text rangeOfString:[NSString stringWithFormat:@"%@：",self.sender_nick]];

    [attributedStr yy_setTextHighlightRange:range color:Color_CommonBlue backgroundColor:RGB_Line_Color tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {


    }];
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(SCREEN_WIDTH-65-20-20, CGFLOAT_MAX) text:attributedStr];
    
    CGFloat commentHeight = layout.textBoundingSize.height;
    
    return commentHeight+8;
}
@end
