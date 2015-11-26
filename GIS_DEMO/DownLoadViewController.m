//
//  DownLoadViewController.m
//  GIS_DEMO
//
//  Created by lost on 15/11/24.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "DownLoadViewController.h"
#import "DataManager.h"
#import "ZipManager.h"

@interface DownLoadViewController ()

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"数据更新";
    
    if (!self.tableView) {
        CGFloat offsetHeight = 0;
        CGRect tableRect = CGRectMake(0, offsetHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
        UITableView *tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    
    DataManager* dtManager = [[DataManager alloc] init];
    _dicMapData = [dtManager getDLDicData];
    _sectionTitle = [dtManager getDLSectionTitle];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)dealloc
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark -- UICollectionViewDataSource

//section （标签）标题显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString* title = [@" " stringByAppendingString:[_sectionTitle objectAtIndex:section]];
    return title;
}

//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_sectionTitle != nil && _sectionTitle.count > 0)
    {
        return _sectionTitle.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (_sectionTitle != nil && _sectionTitle.count > 0)
    {
        NSString* key = [_sectionTitle objectAtIndex:section];
        return ((NSArray*)[_dicMapData objectForKey:key]).count;
    }
    return 0;
}

// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}

//定义每个UICollectionView 的大小
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

//每个UICollectionView展示的内容
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString* key = [_sectionTitle objectAtIndex:indexPath.section];
    MapData* data = [((NSArray*)[_dicMapData objectForKey:key]) objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17.0];
    if ([key isEqualToString:@"热门"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@(%@)",data.drawingType,data.drawingDir,data.managementUnit];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@",data.drawingType,data.drawingDir];;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            
            UIButton* bt = (UIButton*)[cell.contentView viewWithTag:100+indexPath.row];
            if (!bt) {
                bt = [[UIButton alloc] init];
                [cell.contentView addSubview:bt];
            }
            CGSize size = CGSizeMake(80, 36);
            [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-10);
                make.size.mas_equalTo(size);
            }];
            UIImage* normalImage = [UIColor imageWithColor:[UIColor orangeColor] size:size];
            UIImage* highImage = [UIColor imageWithColor:[UIColor lightGrayColor] size:size];
            bt.tag = 100+indexPath.row;
            [bt setTitle:@"下载" forState:UIControlStateNormal];
            [bt setTitle:@"下载" forState:UIControlStateHighlighted];
            [bt setTitle:@"已下载" forState:UIControlStateDisabled];
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [bt setBackgroundImage:normalImage forState:UIControlStateNormal];
            [bt setBackgroundImage:highImage forState:UIControlStateHighlighted];
            bt.layer.cornerRadius = 15;
            bt.titleLabel.textColor = [UIColor whiteColor];
            bt.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [bt addTarget:self action:@selector(dl:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return cell;
}

- (void)dl:(id)sender
{
    NSArray* arrurl = @[@"http://115.159.28.155:8888/mapfiles/b1.zip ",
                        @"http://115.159.28.155:8888/mapfiles/b2.zip "];
    
    
    UIButton* bt = (UIButton*)sender;
    NSLog(@"dl:%ld",(long)bt.tag);
        
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ZipManager* zip = [[ZipManager alloc] init];
    [zip initMainData];
    [zip httpDownloadZipData:[arrurl objectAtIndex:bt.tag-100] result:^(BOOL success) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success) {
            [bt setEnabled:NO];
        }
    }];
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
