//
//  ChangeCityViewController.m
//  Wish
//
//  Created by Lost on 15/8/24.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "MapDataViewController.h"
#import "DataManager.h"

@interface MapDataViewController ()

@end

@implementation MapDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"电网接线图";
    
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
    _dicMapData = [dtManager getDicData];
    _sectionTitle = [dtManager getSectionTitle];
    
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
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = COLOR4RGB(0, 173, 173);
//    for(UIView *view in [self.tableView subviews])
//    {
//        if([[[view class] description] isEqualToString:@"UITableViewIndex"])
//        {
//            for(UIView *sbview in [view subviews])
//            {
//                if ([sbview isKindOfClass:[UILabel class]]) {
//                    ((UILabel*)sbview).font = [UIFont systemFontOfSize:14];
//                }
//            }
//        }
//    }
}

#pragma mark -- UICollectionViewDataSource

//右边索引 字节数(如果不实现 就不显示右侧索引)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _sectionTitle;
}

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

//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    NSString *key = [_sectionTitle objectAtIndex:index];
    NSLog(@"sectionForSectionIndexTitle key=%@",key);
    if (key == UITableViewIndexSearch) {
        //[tableView setContentOffset:CGPointZero animated:YES];
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        return NSNotFound;
    }
    
    return index;
}

//定义每个UICollectionView 的大小
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

//每个UICollectionView展示的内容
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier%ld",(long)indexPath.row];
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString* key = [_sectionTitle objectAtIndex:indexPath.section];
    MapData* data = [((NSArray*)[_dicMapData objectForKey:key]) objectAtIndex:indexPath.row];
    
    //cell.textLabel.textColor = COLOR4RGB(0, 173, 173);
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17.0];
    if ([key isEqualToString:@"热门"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@(%@)",data.drawingType,data.drawingDir,data.managementUnit];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@",data.drawingType,data.drawingDir];;
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeSelect:)]) {
        
        NSString* key = [_sectionTitle objectAtIndex:indexPath.section];
        MapData* data = [((NSArray*)[_dicMapData objectForKey:key]) objectAtIndex:indexPath.row];
        [self.delegate changeSelect:data];
        
        DataManager* dtManager = [[DataManager alloc] init];
        [dtManager setTopData:data];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
