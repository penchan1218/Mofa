//
//  SigningWindow.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/5/31.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigningWindow : UIWindow

- (void)hide;

- (void)show;

- (void)showWithCompletionBlock:(void (^)())completionBlock;

- (void)hideWithCompletionBlock:(void (^)())completionBlock;

@end
