//
//  ATHistoryViewController.m
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATHistoryViewController.h"

@interface ATHistoryViewController ()

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, assign)NSInteger index;

@end

@implementation ATHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"通话历史";
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"navLeft_Back"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(0, 0, 30, 30);
    leftBtn.tag = 100;
    [leftBtn addTarget:self action:@selector(doSomethingEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"navRight_clear"] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(0, 0, 30, 30);
    rightBtn.tag = 101;
    [rightBtn addTarget:self action:@selector(doSomethingEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.tableView.tableFooterView = [[UIView alloc]init];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    ATHistoryModel *model = self.dataArr[indexPath.row];
    cell.historyModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.index ++;
    ATHistoryModel *model = self.dataArr[indexPath.row];
    if (model.callMode != ARP2P_Call_Audio) {
        //视频
        ATVideoViewController *videoVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"Video"];
        videoVc.isCall = YES;
        videoVc.callMode = model.callMode;
        videoVc.peerId = model.phoneStr;
        [self.navigationController pushViewController:videoVc animated:YES];
    } else {
        //音频
        ATAudioViewController *audioVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"Audio"];
        audioVc.callMode = ARP2P_Call_Audio;
        audioVc.peerId = model.phoneStr;
        audioVc.isCall = YES;
        [self.navigationController pushViewController:audioVc animated:YES];
    }
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //删除某一条通话记录
        ATHistoryModel *model = self.dataArr[indexPath.row];
        [ATHistoryTool removeHistoryData:model.date];
        self.dataArr = nil;
        [self.tableView reloadData];
    }];
    return @[action0];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark -other
- (void)doSomethingEvents:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            if (self.dataArr.count == 0) {
                [XHToast showCenterWithText:@"暂无数据"];
                return;
            }
        {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除全部通话记录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [XHToast showCenterWithText:@"删除成功"];
                [ATHistoryTool removeAllObject];
                [self.dataArr removeAllObjects];
                [self.tableView reloadData];
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVc addAction:confirmAction];
            [alertVc addAction:cancleAction];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        [_dataArr addObjectsFromArray:[ATHistoryTool getAllHistoryList]];
        if (_dataArr.count == 0) {
            [XHToast showCenterWithText:@"暂无通话历史"];
        }
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    if (self.index != 0) {
        self.dataArr = nil;
        [self.tableView reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

@end
