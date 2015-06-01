//
//  HomeViewController.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/3/31.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

@end
