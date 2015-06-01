//
//  CropViewController.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/24.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CropImageProtocol <NSObject>

@required
- (void)croppedImageShouldBeUsedWithCompletionBlock:(void (^)())completionBlock;

@end

@interface CropViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) id<CropImageProtocol> delegate;

@end
