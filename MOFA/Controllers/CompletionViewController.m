//
//  CompletionViewController.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/7.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "CompletionViewController.h"
#import "ComplexPictureDecorator.h"
#import "UMSocial.h"

@interface CompletionViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn_wechat_share;
@property (weak, nonatomic) IBOutlet UIButton *btn_qq_share;
@property (weak, nonatomic) IBOutlet UIButton *btn_more_share;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [_separator addConstraint:[NSLayoutConstraint
                               constraintWithItem:_separator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_separator attribute:NSLayoutAttributeHeight multiplier:0.0f constant:0.5]];
    
    [_cancelBtn addTarget:self action:@selector(cancenBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:imageView];
    _imageView = imageView;
    
    [_scrollView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|-(padding)-[_imageView(width)]-(padding)-|"
                                 options:0
                                 metrics:@{@"padding": @([[UIScreen mainScreen] bounds].size.width/10),
                                           @"width": @([[UIScreen mainScreen] bounds].size.width/5*4)}
                                 views:NSDictionaryOfVariableBindings(_imageView)]];
    
    UIImage *decoratedImage = [[ComplexPictureDecorator sharedInstance] decoratedImage];
    _scale = decoratedImage.size.height / decoratedImage.size.width;
    
    _imageView.image = decoratedImage;
    
    [_scrollView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|-(padding)-[_imageView(height)]-(padding)-|"
                                 options:0
                                 metrics:@{@"padding": @(10),
                                           @"height": @([[UIScreen mainScreen] bounds].size.width/5*4*_scale)}
                                 views:NSDictionaryOfVariableBindings(_imageView)]];
    
}
/*
 UMShareToQQ, UMShareToQzone
 */

- (IBAction)sharetoWechat {
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline]
                                                       content:@"分享-来自Mofa"
                                                         image:[[ComplexPictureDecorator sharedInstance] decoratedImage]
                                                      location:nil urlResource:nil
                                           presentedController:self
                                                    completion:^(UMSocialResponseEntity *response) {
                                                        NSLog(@"分享到微信朋友圈成功");
                                                    }];
}

- (IBAction)sharetoQQ {
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone]
                                                       content:@"分享-来自Mofa"
                                                         image:[[ComplexPictureDecorator sharedInstance] decoratedImage]
                                                      location:nil urlResource:nil
                                           presentedController:self
                                                    completion:^(UMSocialResponseEntity *response) {
                                                        NSLog(@"分享到QQ空间成功");
                                                    }];
}

- (IBAction)sharetoMorePlatforms {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5523b588fd98c5e7a80009e9"
                                      shareText:@"分享-来自Mofa"
                                     shareImage:[[ComplexPictureDecorator sharedInstance] decoratedImage]
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatFavorite, UMShareToSina, UMShareToEmail, UMShareToQQ, UMShareToSms]
                                       delegate:nil];
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

- (void)cancenBtnDidClick {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
