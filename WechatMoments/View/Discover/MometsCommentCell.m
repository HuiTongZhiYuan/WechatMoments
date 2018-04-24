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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;


        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:Color_BackgroundGray];
        [self addSubview:_backView];

        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];


        _backButton = [[UIButton alloc] init];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setBackgroundImage:[LMYResource imageNamed:@"ButtonMarkClick"] forState:UIControlStateHighlighted];
        [_backButton setBackgroundColor:[UIColor clearColor]];
        _backButton.alpha = 0.2;
        [self addSubview:_backButton];
        [_backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backView.mas_left);
            make.top.mas_equalTo(self.backView.mas_top);
            make.width.mas_equalTo(self.backView.mas_width);
            make.height.mas_equalTo(self.backView.mas_height);
        }];
    }
    return self;
}


- (void)showMometsCommentCell:(CommentModel *)model
{
    NSLog(@"1111");

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




//    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(4);
//        make.width.mas_equalTo(self.backView.mas_width);
//        make.height.mas_equalTo(self.backView.mas_height);
//    }];
}

- (void)layoutSubviews{

    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(75);
        make.top.mas_equalTo(self.mas_top).mas_offset(4);
        make.right.mas_equalTo(self.mas_right).mas_offset(-30);
    }];

    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(self.mas_right).mas_offset(-20);
        make.height.mas_equalTo(self.contentLabel.mas_height).mas_offset(8);
    }];
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
