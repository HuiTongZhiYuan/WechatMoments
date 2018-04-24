//
//  MeViewController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView * infoTableView;

@property(nonatomic,strong)NSArray * array;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
    _array = [NSArray arrayWithObjects:
              @[@{@"title":[LMYResource LMY_Localized:@"Avatar"],@"image":[LMYResource imageNamed:@"qrcode_for_gh"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"Wallet"],@"image":[LMYResource imageNamed:@"MoreMyBankCard"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"Favorites"],@"image":[LMYResource imageNamed:@"MoreMyFavorites"]},@{@"title":[LMYResource LMY_Localized:@"MyPosts"],@"image":[LMYResource imageNamed:@"MoreMyAlbum"]},
                @{@"title":[LMYResource LMY_Localized:@"CardsOffers"],@"image":[LMYResource imageNamed:@"MyCardPackageIcon"]},@{@"title":[LMYResource LMY_Localized:@"StickerGallery"],@"image":[LMYResource imageNamed:@"MoreExpressionShops"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"Settings"],@"image":[LMYResource imageNamed:@"MoreSetting"]}], nil];
    
    
    _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [_infoTableView setDelegate:self];
    [_infoTableView setDataSource:self];
    [self.view addSubview:_infoTableView];

    //使用AutoLayout约束，禁止将Autoresizing Mask转换为约束
    [_infoTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //上下左右边缘
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:_infoTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:LMY_NavHeight];
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:_infoTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:_infoTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-(LMY_TabbarHeight)];
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:_infoTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];

    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
    [self.view addConstraints:array];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * oneArray = [_array objectAtIndex:section];
    return oneArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 86;
    }
    return 46;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString * CellIdentifier1 = @"userHeadInfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        UIImageView * headImageView = nil;
        UIImageView * qrcodeImageView = nil;
        UILabel * nameLabel = nil;
        UILabel * codeLabel = nil;
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1] ;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            headImageView = [[UIImageView alloc] init];
            [headImageView setTag:11];
            [cell addSubview:headImageView];
            [headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.mas_left).mas_offset(10);
                make.top.mas_equalTo(cell.mas_top).mas_offset(10);
                make.width.mas_equalTo(66);
                make.height.mas_equalTo(66);
            }];
            headImageView.layer.cornerRadius = 33;
            headImageView.layer.masksToBounds = YES;
            
            
            qrcodeImageView = [[UIImageView alloc] init];
            [qrcodeImageView setTag:12];
            [cell addSubview:qrcodeImageView];
            [qrcodeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.mas_right).mas_offset(-40);
                make.top.mas_equalTo(cell.mas_top).mas_offset(28);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            nameLabel = [[UILabel alloc] init];
            [nameLabel setTextColor:RGB_51];
            [nameLabel setBackgroundColor:[UIColor clearColor]];
            [nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
            [nameLabel setTag:13];
            [cell addSubview:nameLabel];
            [nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(headImageView.mas_right).mas_offset(10);
                make.top.mas_equalTo(cell.mas_top).mas_offset(20);
                make.right.mas_equalTo(qrcodeImageView.mas_left).mas_offset(-10);
            }];
            
            codeLabel = [[UILabel alloc] init];
            [codeLabel setTextColor:RGB_51];
            [codeLabel setBackgroundColor:[UIColor clearColor]];
            [codeLabel setFont:[UIFont systemFontOfSize:14]];
            [codeLabel setTag:14];
            [cell addSubview:codeLabel];
            [codeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(headImageView.mas_right).mas_offset(10);
                make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(10);
                make.right.mas_equalTo(qrcodeImageView.mas_left).mas_offset(-10);
            }];
        }
        if (headImageView==nil) {
            headImageView = [cell viewWithTag:11];
        }
        if (qrcodeImageView==nil) {
            qrcodeImageView = [cell viewWithTag:12];
        }
        if (nameLabel==nil) {
            nameLabel = [cell viewWithTag:13];
        }
        if (codeLabel==nil) {
            codeLabel = [cell viewWithTag:14];
        }
        
        [headImageView sd_setImageWithURL:[NSURL URLWithString:[LMYUserLoginModel shareInstance].avatar] placeholderImage:[LMYResource imageNamed:@"DefaultHead"]];
        nameLabel.text = [LMYUserLoginModel shareInstance].nick;
        codeLabel.text = @"wx_123456";
        
        if (indexPath.section < _array.count) {
            NSArray * oneArray = [_array objectAtIndex:indexPath.section];
            NSDictionary * dic = [oneArray objectAtIndex:indexPath.row];
            //            NSString * title = [dic objectForKey:@"title"];
            UIImage * image = [dic objectForKey:@"image"];
            
            qrcodeImageView.image = image;
        }
        
        
        return cell;
    }
    
    
    
    static NSString *CellIdentifier = @"userInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.textLabel setTextColor:RGB_51];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    if (indexPath.section < _array.count) {
        
        NSArray * oneArray = [_array objectAtIndex:indexPath.section];
        
        NSDictionary * dic = [oneArray objectAtIndex:indexPath.row];
        
        NSString * title = [dic objectForKey:@"title"];
        UIImage * image = [dic objectForKey:@"image"];
        
        cell.imageView.image = image;
        cell.textLabel.text = title;
        
        return cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        
    }
    else  if (indexPath.section == 1)
    {
        
    }
    else  if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
        }
        else if (indexPath.row == 1)
        {
        }
        else if (indexPath.row == 2)
        {
        }
        else if (indexPath.row == 3)
        {
        }
    }
    else  if (indexPath.section == 3)
    {
        
    }
}


@end
