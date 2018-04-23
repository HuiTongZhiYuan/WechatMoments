//
//  MometsCommentCell.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MometsCommentCell.h"
#import "CommentModel.h"

@interface MometsCommentCell()
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIButton * backButton;
@property(nonatomic,strong)YYLabel * contentLabel;


@end




@implementation MometsCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - 懒加载
- (UIView *)backView
{
    if (!_backView) {
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(65, 0, SCREEN_WIDTH-65-20, self.l_height)];
        [backView setBackgroundColor:Color_BackgroundGray];
        [self addSubview:_backView = backView];
    }
    return _backView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.backView.l_width, self.backView.l_height)];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [backButton setBackgroundImage:[LMYResource imageNamed:@"ButtonMarkClick"] forState:UIControlStateHighlighted];
        [backButton setBackgroundColor:[UIColor clearColor]];
        backButton.alpha = 0.2;
        [self.backView addSubview:_backButton = backButton];
    }
    return _backButton;
}

- (YYLabel *)contentLabel
{
    if (!_contentLabel) {
        YYLabel * contentLabel = [[YYLabel alloc] initWithFrame:CGRectMake(10, 4, self.backView.l_width-20, 40)];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        contentLabel.numberOfLines = 0;
        [self.backView addSubview:_contentLabel = contentLabel];
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}


- (void)showMometsCommentCell:(CommentModel *)model
{
    NSLog(@"1111");
    
    self.contentLabel.l_width = self.backView.l_width-20;
    NSString * text = [NSString stringWithFormat:@"%@：%@",model.sender_nick,model.content];
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString: text];
    attributedStr.yy_color = RGB_51;
    attributedStr.yy_font = [UIFont systemFontOfSize:14];
    
    NSRange range = [text rangeOfString:[NSString stringWithFormat:@"%@：",model.sender_nick]];
    
    [attributedStr yy_setTextHighlightRange:range color:Color_CommonBlue backgroundColor:RGB_Line_Color tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectCommentSender:)]) {
            [self.delegate selectCommentSender:self.indexPath];
        }
        // 点击
        NSLog(@"-=-=-=-=-= %@",[text.string substringWithRange:range]);
    }];
    
    self.contentLabel.attributedText = attributedStr;
    [self.contentLabel sizeToFit];
    self.backView.l_height = self.contentLabel.l_height+8;
    self.backButton.l_height = self.backView.l_height;
}


- (void)backButtonClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCommentCell:)]) {
        [self.delegate selectCommentCell:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
