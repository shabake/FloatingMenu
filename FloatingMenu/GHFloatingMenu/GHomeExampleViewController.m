//
//  GHomeExampleViewController.m
//  FloatingMenu
//
//  Created by mac on 2020/2/16.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "GHomeExampleViewController.h"
#import "GHomeExampleCell.h"

@interface GHomeExampleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  头部
 */
@property (nonatomic , strong) UIView *header;

/**
 *  悬浮Menu
 */
@property (nonatomic , strong) UIView *floatingMenu;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *layout;
@property (nonatomic , assign) CGFloat oldY;

@end

@implementation GHomeExampleViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.header];
    [self.view addSubview:self.floatingMenu];
    [self.view addSubview:self.collectionView];
    [self beginRefreshing];
}

- (void)beginRefreshing{
    [self.collectionView.mj_header beginRefreshing];
    [self.collectionView.mj_footer beginRefreshing];
}

- (void)endRefreshing{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
}

- (void)refreshData {
    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
}

- (void)loadMoreData{
    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kWidth/2.01,280);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GHomeExampleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHomeExampleCellID" forIndexPath:indexPath];
    cell.title.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.oldY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = kSafeAreaTopHeight+ 44;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (scrollView.isDragging ||scrollView.isTracking) {
        if (contentOffsetY > self.oldY && self.floatingMenu.y > kSafeAreaTopHeight) {
            [UIView animateWithDuration: 0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.floatingMenu.y = 0;
                self.header.y = -CGRectGetMaxY(self.header.frame);
                self.collectionView.y = CGRectGetMaxY(self.floatingMenu.frame);
                self.collectionView.height = kScreenHeight - (kSafeAreaTopHeight + 44);
            } completion:nil];
        } else if (contentOffsetY < self.oldY && self.floatingMenu.y < height){
            [UIView animateWithDuration: 0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.header.y = 0;
                self.floatingMenu.y = CGRectGetMaxY(self.header.frame);
                self.collectionView.y = CGRectGetMaxY(self.floatingMenu.frame);
            } completion:nil];
        }
    }
}

- (void)clickButton {
    [self.collectionView.mj_header beginRefreshing];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil){
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.floatingMenu.frame), kWidth, KHeight - CGRectGetMaxY(self.floatingMenu.frame)) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GHomeExampleCell class] forCellWithReuseIdentifier:@"GHomeExampleCellID"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        weakself(self);
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshData];
        }];
        header.lastUpdatedTimeLabel.hidden = NO;
        header.stateLabel.hidden = NO;
        _collectionView.mj_header = header;
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.minimumInteritemSpacing = 1;
        _layout.minimumLineSpacing = 1;
    }
    return _layout;
}

- (UIView *)floatingMenu {
    if (_floatingMenu == nil) {
        _floatingMenu = [[UIView alloc]init];
        _floatingMenu.frame = CGRectMake(0, CGRectGetMaxY(self.header.frame), kWidth, 44);
        _floatingMenu.backgroundColor = [UIColor orangeColor];
        UIButton *text = [[UIButton alloc]init];
        text.titleLabel.font = [UIFont systemFontOfSize:18];
        [text setTitleColor:UIColorFromRGB(0x33333) forState:UIControlStateNormal];
        [text setTitle:@"悬浮菜单 点击开始刷新" forState:UIControlStateNormal];
        text.frame = CGRectMake(20, 0, kScreenWidth - 40, 44);
        [text addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        [_floatingMenu addSubview:text];
    }
    return _floatingMenu;
}

- (UIView *)header {
    if (_header == nil) {
        _header = [[UIView alloc]init];
        _header.frame = CGRectMake(0, 0, kWidth, 200);
        _header. backgroundColor = [UIColor whiteColor];
        UILabel *text = [[UILabel alloc]init];
        text.font = [UIFont systemFontOfSize:18];
        text.textColor = UIColorFromRGB(0x333333);
        text.numberOfLines = 0;
        text.text = @"跟随滑动的头部";
        text.frame = CGRectMake(20, 0, kScreenWidth, 200);
        [_header addSubview:text];
    }
    return _header;
}

@end
