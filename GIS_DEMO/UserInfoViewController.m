//
//  UserInfoViewController.m
//  GIS_DEMO
//
//  Created by lost on 15/10/25.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UserInfoViewController.h"
#import "PublicHeader.h"
#import "PersonalInfoAvatarCell.h"
#import "DownLoadViewController.h"

@interface UserInfoViewController ()
{
    NSMutableArray* _arrayData1;
    NSMutableArray* _arrayData2;
}

@property (nonatomic,strong)UITableView *   tableView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.tableView) {
        CGFloat offsetHeight = 0;
        CGRect tableRect = CGRectMake(0, offsetHeight, SCREEN_WIDTH, SCREEN_HEIGHT-0);
        UITableView *tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    
    self.navigationItem.title = @"个人账户";
    
    
    if(_arrayData1 == nil)
    {
        _arrayData1 = [[NSMutableArray alloc] init];
        [_arrayData1 addObject:@"数据更新"];
        [_arrayData1 addObject:@"软件更新"];
    }
    
    if(_arrayData2 == nil)
    {
        _arrayData2 = [[NSMutableArray alloc] init];
        [_arrayData2 addObject:@"参数设置"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return  0;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_arrayData1 count]+1;
    }
    if (section == 1) {
        return [_arrayData2 count];
    }
    return 0;
}

//定义每个UICollectionView 的大小
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 120;
    }
    return 50;
}

//每个UICollectionView展示的内容
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier%ld",(long)indexPath.row];
            PersonalInfoAvatarCell *cell = (PersonalInfoAvatarCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil) {
                cell = [[PersonalInfoAvatarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            
            cell.backgroundColor = COLOR4RGB(240, 240, 240);
            [cell setData];
            
            return cell;
        }
        else
        {
            NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier%ld",(long)indexPath.row];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            
            cell.backgroundColor = [UIColor whiteColor];
            
            NSString* data = [_arrayData1 objectAtIndex:indexPath.row-1];
            cell.textLabel.text = data;
            cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.0];
            
            return cell;
        }
    }
    
    if (indexPath.section == 1) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        
        NSString* data = [_arrayData2 objectAtIndex:indexPath.row];
        cell.textLabel.text = data;
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.0];
        
        return cell;
    }
    else
    {
        return nil;
    }
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        DownLoadViewController* fViewController = [[DownLoadViewController alloc] init];
        fViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fViewController animated:YES];
    }
}

@end
