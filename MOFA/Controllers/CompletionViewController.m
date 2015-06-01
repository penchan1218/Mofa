//
//  CompletionViewController.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/7.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "CompletionViewController.h"
#import "ComplexPictureDecorator.h"

@interface CompletionViewController ()

@end

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
