//
//  CropViewController.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/24.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "CropViewController.h"
#import "ComplexPictureDecorator.h"
#import "BJImageCropper.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define SHOW_PREVIEW    YES

@interface CropViewController ()

//@property (weak, nonatomic) UIButton *crossBtn;
//@property (weak, nonatomic) UIButton *tickBtn;

@property (weak, nonatomic) BJImageCropper *imageCropper;
@property (weak, nonatomic) UIImageView *preview;

@property (nonatomic, assign) BOOL isModified;

@end

@implementation CropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BACKGROUND_DRAK;
    _isModified = NO;
    
    UIView *customTopBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                    SCREEN_SIZE.width,
                                                                    60)];
    customTopBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:customTopBar];
    
    UIButton *backwardBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    [backwardBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    backwardBtn.showsTouchWhenHighlighted = YES;
    [backwardBtn addTarget:self action:@selector(backwardBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [customTopBar addSubview:backwardBtn];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width-10-50, 5,
                                                                      50, 50)];
    [confirmBtn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    confirmBtn.showsTouchWhenHighlighted = YES;
    [confirmBtn addTarget:self action:@selector(confirmModification) forControlEvents:UIControlEventTouchUpInside];
    [customTopBar addSubview:confirmBtn];
    
    
    
    
    BJImageCropper *imageCropper = [[BJImageCropper alloc] initWithImage:[[ComplexPictureDecorator sharedInstance] image]
                                                              andMaxSize:CGRectInset(self.view.bounds, 0, 60).size];
    [self.view addSubview:imageCropper];
    _imageCropper = imageCropper;
    
    _imageCropper.center = self.view.center;
    _imageCropper.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _imageCropper.imageView.layer.shadowRadius = 3.0f;
    _imageCropper.imageView.layer.shadowOpacity = 0.8f;
    _imageCropper.imageView.layer.shadowOffset = CGSizeMake(1, 1);
    
    [_imageCropper addObserver:self forKeyPath:@"crop" options:NSKeyValueObservingOptionNew context:nil];
    
    if (SHOW_PREVIEW) {
        UIImageView *preview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60,
                                                                             _imageCropper.crop.size.width * 0.1,
                                                                             _imageCropper.crop.size.height * 0.1)];
        preview.image = [_imageCropper getCroppedImage];
        preview.clipsToBounds = YES;
        preview.layer.borderColor = [UIColor whiteColor].CGColor;
        preview.layer.borderWidth = 2.0;
        [self.view addSubview:preview];
        _preview = preview;
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:_imageCropper] &&
        [keyPath isEqualToString:@"crop"]) {
        _isModified = YES;
        [self updateDisplay];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateDisplay {
    if (SHOW_PREVIEW) {
        _preview.image = [_imageCropper getCroppedImage];
        _preview.frame = CGRectMake(10, 60,
                                    _imageCropper.crop.size.width * 0.1,
                                    _imageCropper.crop.size.height * 0.1);
    }
}

- (void)backwardBtnDidClick {
    if (_isModified) {
        UIAlertView *backwardAlert = [[UIAlertView alloc] initWithTitle:@"注意"
                                                                message:@"确定放弃修改并返回?"
                                                               delegate:self
                                                      cancelButtonTitle:@"留在此处"
                                                      otherButtonTitles:@"继续返回", nil];
        backwardAlert.tag = 1000;
        [backwardAlert show];
    } else {
        [self popToPreviousVC];
    }
}

- (void)confirmModification {
    UIImage *croppedImage = [_imageCropper getCroppedImage];
    [[ComplexPictureDecorator sharedInstance] setImage:croppedImage];
    
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"处理中";
    [self.view addSubview:hud];
    [hud show:YES];
    
    if (self.delegate != nil) {
        __weak MBProgressHUD *weakHUD = hud;
        [self.delegate croppedImageShouldBeUsedWithCompletionBlock:^{
            [weakHUD hide:YES];
        }];
    }
}

- (void)popToPreviousVC {
    [_imageCropper removeObserver:self forKeyPath:@"crop"];
    _imageCropper = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - delegate - alert view

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1000 &&
        buttonIndex == 1) {
        [self popToPreviousVC];
    }
}

@end
