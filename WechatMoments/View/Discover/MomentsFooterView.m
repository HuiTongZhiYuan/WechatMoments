//
//  MomentsFooterView.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentsFooterView.h"

@implementation MomentsFooterView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIView * lineLabel = [[UIView alloc] initWithFrame:CGRectMake(0, 15.5, SCREEN_WIDTH, 0.5)];
        [lineLabel setBackgroundColor:Color_Line_Background];
        [self addSubview:lineLabel];
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
