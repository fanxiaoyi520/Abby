//
//  ABProfileViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABProfileViewController.h"
#import "ABNickNameViewController.h"
#import "ABPreviewViewController.h"
#import "ABProfileCell.h"
#import "ABProfileModel.h"

@interface ABProfileViewController ()<UITableViewDelegate,UITableViewDataSource,GWGlobalNotifyServerDelegate>

@property (nonatomic ,strong) NSArray *dataArray;
@property (nonatomic ,strong) ABProfileModel *model;
@end

@implementation ABProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"Profile";
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    
    self.dataArray = @[@[@"Profile Photo",@"Nick Name",@"Abby ID"],@[@"Sign out of account"]];
    self.model = [ABProfileModel new];
    self.model.nickName = self.mineServerModel.nickName;
    self.model.imageName = self.mineServerModel.avatarPicture;
    self.model.abbyId = self.mineServerModel.abbyId;
    
    [self setupUI];
}

- (void)setupUI {
    self.meTableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight);
    [self.view addSubview:self.meTableView];
    [self.meTableView registerClass:[ABProfileCell class] forCellReuseIdentifier:NSStringFromClass([ABProfileCell class])];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meTableView.mj_header.hidden = YES;
    self.meTableView.mj_footer.hidden = YES;
}

// MARK: tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _dataArray[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) return 70;
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABProfileCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = KWhiteColor;
    [cell setModel:self.model withTitleStr:_dataArray[indexPath.section][indexPath.row] withIndexPath:indexPath];
    NSArray *array = _dataArray[indexPath.section];
    if (indexPath.row == array.count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) return 16;
    return .01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) return;
        if (indexPath.row == 0) {
            ABPreviewViewController *vc = [ABPreviewViewController new];
            vc.mineServerModel = self.mineServerModel;
            [self.navigationController pushViewController:vc animated:YES];
            vc.block = ^{
                [UIViewController jaf_showHudTip:@"Saved successfully"];
            };
        } else {
            ABNickNameViewController *vc = [ABNickNameViewController new];
            vc.nickName = self.model.nickName;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Sign out of your current account?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UserManager sharedUserManager] logout:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:otherAction];
        [alertController addAction:cancelAction];
        [cancelAction setValue:[UIColor colorWithHexString:@"0xF72E47"] forKey:@"_titleTextColor"];
        [otherAction setValue:[UIColor colorWithHexString:@"0x006241"] forKey:@"_titleTextColor"];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

// MARK: 多播代理
- (void)resetUserName:(NSString *)userName {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.model.nickName = userName;
        [self.meTableView reloadData];
    });
}

- (void)resetUserHeaderImage:(NSString *)imageStr {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mineServerModel.avatarPicture = self.model.imageName = imageStr;
        [self.meTableView reloadData];
    });
}
@end
