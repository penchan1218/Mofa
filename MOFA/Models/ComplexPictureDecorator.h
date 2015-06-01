//
//  ComplexPictureDecorator.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/3.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ComplexPictureOwner.h"

@interface ComplexPictureDecorator : NSObject

@property (weak, nonatomic) ComplexPictureOwner *owner;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) UIImage *decoratedImage;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, copy) NSString *phoneType;

+ (ComplexPictureDecorator *)sharedInstance;

- (void)decorateComplexPicture:(ComplexPictureOwner *)owner;

@end
