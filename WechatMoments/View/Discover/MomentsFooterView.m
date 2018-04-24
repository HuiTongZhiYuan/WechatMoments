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
        
        UIView * lineLabel = [[UIView alloc] init];
        [lineLabel setBackgroundColor:Color_Line_Background];
        [self addSubview:lineLabel];

        [lineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(15.5);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(0.5);
        }];
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
