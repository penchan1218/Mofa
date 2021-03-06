//
//  UIView+MBProgressHUD.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/28.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (MBProgressHUD)

- (MBProgressHUD *)showHudWithText:(NSString *)text mode:(MBProgressHUDMode)mode waiting:(BOOL)waiting;

@end
