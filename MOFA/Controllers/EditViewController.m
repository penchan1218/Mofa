//
//  EditViewController.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/3/31.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "EditViewController.h"
#import "ComplexPictureDecorator.h"
#import "QuartzCore/QuartzCore.h"
#import "CompletionViewController.h"
#import "CropViewController.h"

@interface EditViewController () <CropImageProtocol> {
    float customTopBar_height;
}

@end

@implementation EditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    customTopBar_height = 60.0f;
    
    _complexPictureOwner = [[ComplexPictureOwner alloc] init];
    [[NSBundle mainBundle] loadNibNamed:@"ComplexPicture"
                                  owner:_complexPictureOwner options:nil];
    _complexPictureOwner.ibView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_complexPictureOwner.ibView];
    
    [[ComplexPictureDecorator sharedInstance] decorateComplexPicture:_complexPictureOwner];
    
    [_complexPictureOwner.ibView addConstraint:[NSLayoutConstraint
                                                constraintWithItem:_complexPictureOwner.ibView attribute:NSLayoutAttributeWidth
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:0.0f constant:SCREEN_SIZE.width*5/6]];
    [_scrollView addConstraint:[NSLayoutConstraint
                                constraintWithItem:_complexPictureOwner.ibView attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                toItem:_scrollView attribute:NSLayoutAttributeCenterX
                                multiplier:1.0f constant:0.0f]];
    [_scrollView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|-(padding)-[ibView]-(padding)-|"
                                 options:0
                                 metrics:@{@"padding": @(10)}
                                 views:@{@"ibView": _complexPictureOwner.ibView}]];
    
    [_cancelBtn addTarget:self
                   action:@selector(cancelBtnDidClick)
         forControlEvents:UIControlEventTouchUpInside];
    
    [_confirmBtn addTarget:self
                    action:@selector(confirmBtnDidClick)
          forControlEvents:UIControlEventTouchUpInside];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)cancelBtnDidClick {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)confirmBtnDidClick {
    
//    UIImage *image = [self captureCurrentView:_complexPictureOwner.ibView];
//    [[ComplexPictureDecorator sharedInstance] setDecoratedImage:image];
//    [self saveImageToPhotos:image];
//    CompletionViewController *completionView = [[CompletionViewController alloc] init];
//    [self.navigationController pushViewController:completionView animated:YES];
    
    CropViewController *cropVC = [[CropViewController alloc] init];
    cropVC.delegate = self;
    [self.navigationController pushViewController:cropVC animated:YES];
    
}

- (UIImage *)captureCurrentView:(UIView *)view {
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (void)saveImageToPhotos:(UIImage *)image {
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {
    
    if (error) {
        NSLog(@"保存图片失败,失败原因:%@", error);
    } else {
        NSLog(@"保存图片成功");
    }
    
}

#pragma mark - deleate - Crop Image

- (void)croppedImageShouldBeUsedWithCompletionBlock:(void (^)())completionBlock {
    _complexPictureOwner.image = [ComplexPictureDecorator sharedInstance].image;
    
    if (completionBlock != nil) {
        completionBlock();
    }
}

@end
