//
//  DiscoverViewController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//


//使用Auto Layout约束




#import "DiscoverViewController.h"
#import "MomentsViewController.h"

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView * discoverTableView;

@property(nonatomic,strong)NSArray * array;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _array = [NSArray arrayWithObjects:
              @[@{@"title":[LMYResource LMY_Localized:@"Moments"],@"image":[LMYResource imageNamed:@"ff_IconShowAlbum"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"ScanQRCode"],@"image":[LMYResource imageNamed:@"ff_IconQRCode"]},@{@"title":[LMYResource LMY_Localized:@"Shake"],@"image":[LMYResource imageNamed:@"ff_IconShake"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"TopStories"],@"image":[LMYResource imageNamed:@"contactflag_star_mark"]},@{@"title":[LMYResource LMY_Localized:@"Search"],@"image":[LMYResource imageNamed:@"setting_pluginInstall"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"PeopleNearby"],@"image":[LMYResource imageNamed:@"ff_IconLocationService"]},@{@"title":[LMYResource LMY_Localized:@"MessageInABottle"],@"image":[LMYResource imageNamed:@"FriendCardNodeIconBottle"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"Shoping"],@"image":[LMYResource imageNamed:@"CreditCard_ShoppingBag"]},@{@"title":[LMYResource LMY_Localized:@"Games"],@"image":[LMYResource imageNamed:@"MoreGame"]}],
              @[@{@"title":[LMYResource LMY_Localized:@"MiniPrograms"],@"image":[LMYResource imageNamed:@"Action_ReadOriginal"]}], nil];
    
    
    _discoverTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_discoverTableView setDelegate:self];
    [_discoverTableView setDataSource:self];
    [self.view addSubview:_discoverTableView];


    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
    [_discoverTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:_discoverTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:LMY_NavHeight];
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:_discoverTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:_discoverTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-(LMY_TabbarHeight)];
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:_discoverTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];

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
    return 46;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"discoverInfoCell";
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
        MomentsViewController * momentsCtl = [[MomentsViewController alloc] init];
        [self.navigationController pushViewController:momentsCtl animated:YES];
    }
    else  if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
        }
        else if (indexPath.row == 1)
        {
        }
    }
    else  if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
        }
        else if (indexPath.row == 1)
        {
        }
    }
    else  if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
        }
        else if (indexPath.row == 1)
        {
        }
    }
    else if (indexPath.section == 4)
    {
        
    }
    else if (indexPath.section == 5)
    {
        
    }
}


@end
