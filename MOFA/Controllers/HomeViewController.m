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
#import "SigningWindow.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    SigningWindow *sw = [[SigningWindow alloc] init];
    [sw show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 主页三个按钮的回调

- (IBAction)cameraBtnDidClick {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您的摄像头暂不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    } else {
        
        [self showImagePickerType:UIImagePickerControllerSourceTypeCamera];
    }
    
}

- (IBAction)pictureBtnDidClick {
    [self showImagePickerType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)settingBtnDidClick {
    
}

#pragma mark - 系统摄像头或者系统相册的调用

- (void)showImagePickerType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - delegate - image picker

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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
