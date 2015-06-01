//
//  HomeViewController.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/3/31.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "HomeViewController.h"
#import "EditViewController.h"
#import "ComplexPictureDecorator.h"
//#import "UMSocial.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_cameraBtn setImage:[UIImage imageNamed:@"camera_1"] forState:UIControlStateHighlighted];
    [_pictureBtn setImage:[UIImage imageNamed:@"picture_1"] forState:UIControlStateHighlighted];
    [_settingBtn setImage:[UIImage imageNamed:@"setting_1"] forState:UIControlStateHighlighted];
    
    [_cameraBtn addTarget:self action:@selector(cameraBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [_pictureBtn addTarget:self action:@selector(pictureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [_settingBtn addTarget:self action:@selector(settingBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cameraBtnDidClick {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您的摄像头暂不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    } else {
        
        [self showImagePickerType:UIImagePickerControllerSourceTypeCamera];
        
    }
    
}

- (void)pictureBtnDidClick {
    [self showImagePickerType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)settingBtnDidClick {
    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"5523b588fd98c5e7a80009e9"
//                                      shareText:@"分享-来自Mofa"
//                                     shareImage:[UIImage imageNamed:@"setting_1"]
//                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite, UMShareToSina]
//                                       delegate:nil];
    
}

- (void)showImagePickerType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [[ComplexPictureDecorator sharedInstance] setImage:info[UIImagePickerControllerOriginalImage]];
    
    __weak HomeViewController *weakvc = self;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            EditViewController *editView = [[EditViewController alloc] init];
            [weakvc.navigationController pushViewController:editView animated:YES];
            
        });
        
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
