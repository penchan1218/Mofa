//
//  UIView+MBProgressHUD.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/28.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "UIView+MBProgressHUD.h"

@implementation UIView (MBProgressHUD)

- (MBProgressHUD *)showHudWithText:(NSString *)text mode:(MBProgressHUDMode)mode waiting:(BOOL)waiting {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.labelText = text;
    hud.mode = mode;
    [self addSubview:hud];
    [hud show:YES];
    if (!waiting) {
        [hud hide:YES afterDelay:1.0];
    }
    
    return hud;
}

@end
