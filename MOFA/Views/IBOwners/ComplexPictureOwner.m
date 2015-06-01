//
//  ComplexPictureOwner.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/1.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "ComplexPictureOwner.h"

@implementation ComplexPictureOwner

- (void)setImage:(UIImage *)image {
    
    _image = image;
    _imageView.image = image;
    
}

@end
