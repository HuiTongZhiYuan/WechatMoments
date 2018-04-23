//
//  MometsCommentCell.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;

@protocol MometsCommentCellDelegate <NSObject>
- (void)selectCommentSender:(NSIndexPath *)indexPath;
- (void)selectCommentCell:(NSIndexPath *)indexPath;
@end


@interface MometsCommentCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath * indexPath;

@property(nonatomic,weak)id<MometsCommentCellDelegate>delegate;

- (void)showMometsCommentCell:(CommentModel *)model;

@end
