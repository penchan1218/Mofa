//
//  EditViewController.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/3/31.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplexPictureOwner.h"

@interface EditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topBar;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) ComplexPictureOwner *complexPictureOwner;

@property (weak, nonatomic) IBOutlet UIScrollView *choosePhoneTypeScrollView;

@property (weak, nonatomic) IBOutlet UIView *bottomBar;

@property (weak, nonatomic) IBOutlet UIButton *signBtn;

@property (weak, nonatomic) IBOutlet UIButton *cutBtn;
@end
