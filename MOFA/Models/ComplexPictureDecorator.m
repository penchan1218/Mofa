//
//  ComplexPictureDecorator.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/3.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "ComplexPictureDecorator.h"
#import "UIDevice+DeviceType.h"

@implementation ComplexPictureDecorator

+ (ComplexPictureDecorator *)sharedInstance {
    
    static ComplexPictureDecorator *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[ComplexPictureDecorator alloc] init];
        
        sharedInstance.phoneType = [[UIDevice currentDevice] machine];
        
    });
    return sharedInstance;
    
}

- (void)decorateComplexPicture:(ComplexPictureOwner *)owner {
    
    _owner = owner;
    
    [owner.imageView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:owner.imageView attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:owner.imageView attribute:NSLayoutAttributeHeight
                                    multiplier:_scale constant:0.0f]];
    
    if (_image) {
        owner.image = _image;
    }
    
    if (_phoneType && _phoneType.length > 0) {
        _owner.phoneTypeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"phone_type_%@", _phoneType]];
    }
    
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    _size = image.size;
    _scale = _size.width/_size.height;
    
}

- (void)setPhoneType:(NSString *)phoneType {
    
    if (!(_phoneType && [_phoneType isEqualToString:phoneType])) {
        _phoneType = [phoneType copy];
    }
    
    if (_owner) {
        _owner.phoneTypeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"phone_type_%@", phoneType]];
    }
    
}

@end
