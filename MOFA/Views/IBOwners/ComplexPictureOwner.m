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

- (void)setImageScaleConstraint:(NSLayoutConstraint *)imageScaleConstraint {
    
    _imageScaleConstraint = imageScaleConstraint;
    [_imageView addConstraint:_imageScaleConstraint];
}

- (void)setName:(NSString *)name {
    
    if (name && name.length > 0) {
        _byLabel.text = @"by";
        _nameLabel.text = [name copy];
    } else {
        _byLabel.text = nil;
        _nameLabel.text = nil;
    }
}

@end
