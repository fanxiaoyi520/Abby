//
//  ABPreviewViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/14.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPreviewViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ABPreviewViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic ,strong) UIView *backgroundView;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) UIButton *saveBtn;
@property (nonatomic ,strong) UIButton *replaceBtn;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation ABPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.isShowLiftBack = NO;
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    
    [self setupUI];
}

- (void)setupUI {
    self.backgroundView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayorHideFuncView:)];
    [self.backgroundView addGestureRecognizer:tap];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.mineServerModel.avatarPicture] placeholderImage:Default_Avatar];
    self.imageView.backgroundColor = KBlackColor;
    UIImage *image = self.imageView.image;
    self.imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
    
    CGFloat cancelBtn_w = [self.cancelBtn.titleLabel.text getWidthWithHeight:22 Font:[UIFont systemFontOfSize:17]];
    _cancelBtn.frame = CGRectMake(16, YTVIEW_STATUSBAR_HEIGHT+12, cancelBtn_w, 22);
    [_cancelBtn jaf_setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];

    CGFloat saveBtn_w = [self.saveBtn.titleLabel.text getWidthWithHeight:22 Font:[UIFont systemFontOfSize:17]];
    _saveBtn.frame = CGRectMake(kScreenWidth-saveBtn_w-16, YTVIEW_STATUSBAR_HEIGHT+12, saveBtn_w, 22);
    [_saveBtn jaf_setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];

    CGFloat replaceBtn_w = [self.replaceBtn.titleLabel.text getWidthWithHeight:22 Font:[UIFont systemFontOfSize:17]];
    _replaceBtn.frame = CGRectMake(16, KScreenHeight-22-24-CONTACTS_SAFE_BOTTOM, replaceBtn_w, 22);
    [_replaceBtn jaf_setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
}

// MARK: actions
- (void)displayorHideFuncView:(UITapGestureRecognizer*)tap {
    _cancelBtn.hidden = !_cancelBtn.hidden;
    _replaceBtn.hidden = !_replaceBtn.hidden;
    _saveBtn.hidden = !_saveBtn.hidden;
}

- (void)replaceAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Choose from Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self checkAlbumPermission];//检查相册权限
        });
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self checkCameraPermission];//检查相机权限
        });
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [alert addAction:action2];
    [alert addAction:cancle];
    [[UIViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

-(void)hideImage:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction:(UIButton *)sender {
    [ABMineInterface mine_transportImgToServerWithImg:self.imageView.image success:^(id  _Nonnull responseObject) {
        [ABMineInterface mine_userAvatarWithParams:@{@"avatar":responseObject[@"data"]} success:^(id  _Nonnull responseObject2) {
            [[ABGlobalNotifyServer sharedServer] postChangeUserHeaderImage:responseObject[@"data"]];
            [self.navigationController popViewControllerAnimated:YES];
            if (self.block) self.block();
        }];
    }];
}

//MARK: - Camera
- (void)checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self takePhoto];
            }
        }];
    } else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [UIViewController jaf_showHudTip:@"No camera permissions"];
    } else {
        [self takePhoto];
    }
}

- (void)takePhoto {
    //判断相机是否可用，防止模拟器点击【相机】导致崩溃
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:^{
            
        }];
    } else {
        NSLog(@"不能使用模拟器进行拍照");
    }
}

// MARK: - Album
- (void)checkAlbumPermission {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    [self selectAlbum];
                }
            });
        }];
    } else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self alertAlbum];
    } else {
        [self selectAlbum];
    }
}

- (void)selectAlbum {
    //判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:^{

        }];
    }
}

- (void)alertAlbum {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置中打开相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

// MARK: - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    self.imageView.image = image;
}

// MARK: Lazy loading
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = KBlackColor;
        [self.view addSubview:_backgroundView];
    }
    return _backgroundView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.backgroundView addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backgroundView addSubview:_cancelBtn];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(hideImage:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.hidden = NO;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _cancelBtn;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backgroundView addSubview:_saveBtn];
        _saveBtn.backgroundColor = [UIColor clearColor];
        [_saveBtn setTitle:@"Save" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.hidden = NO;
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _saveBtn;
}


- (UIButton *)replaceBtn {
    if (!_replaceBtn) {
        _replaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backgroundView addSubview:_replaceBtn];
        _replaceBtn.backgroundColor = [UIColor clearColor];
        [_replaceBtn setTitle:@"Replace" forState:UIControlStateNormal];
        [_replaceBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_replaceBtn addTarget:self action:@selector(replaceAction:) forControlEvents:UIControlEventTouchUpInside];
        _replaceBtn.hidden = NO;
        _replaceBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _replaceBtn;
}

- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self; //delegate遵循了两个代理
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}
@end
