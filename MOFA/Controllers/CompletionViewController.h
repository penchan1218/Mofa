//
//  CompletionViewController.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/7.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) float scale;

@property (weak, nonatomic) UIImageView *imageView;

@end
