//
//  MomentsPostView.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

//一条内容视图
#import <Foundation/Foundation.h>
@class MomentsModel;
@class MomentsModel;
//一个帖子内容
//0 顶部
//1 名字
//2 内容
//3 图片
//4 地址
//5 时间
//6 底部

#define topHeight 16  //顶部高度
#define AllInterval 10  //间隔：内容-名字，图片-内容，地址-图片，时间-地址
#define NAME_CONTENT_WIDTH SCREEN_WIDTH-72-12  //名字、内容 宽度




@protocol MomentsPostViewDelegate <NSObject>
- (void)controlButtonClick:(NSInteger)section but:(UIButton *)sender;
@end



@interface MomentsPostView : UITableViewHeaderFooterView


@property(nonatomic,assign)NSInteger section;

@property(nonatomic,weak)id<MomentsPostViewDelegate>delegate;


//显示内容
- (void)showMomentsPostView:(MomentsModel *)model;

//计算高度
+ (CGFloat)heightWithModel:(MomentsModel *)model;

@end
