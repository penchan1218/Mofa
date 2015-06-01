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
    
    static ComplexPictureDecorator *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        __sharedInstance = [[ComplexPictureDecorator alloc] init];
        
        NSString *phoneType = [[UIDevice currentDevice] machine];
        
        NSString *location = [[NSBundle mainBundle] pathForResource:@"ShownPhoneTypes" ofType:@"plist"];
        __sharedInstance.shownPhoneTypes = [NSArray arrayWithContentsOfFile:location];
        NSArray *shownPhoneTypes = __sharedInstance.shownPhoneTypes;
        
        for (NSInteger i = 0; i < shownPhoneTypes.count; i++) {
            NSString *shownPhoneType = shownPhoneTypes[i];
            if ([[@"iPhone " stringByAppendingString:shownPhoneType] isEqualToString:phoneType]) {
                __sharedInstance.selectedPhoneType = i;
                break;
            }
        }
        
        __sharedInstance.images = [NSMutableArray array];
    });
    
    return __sharedInstance;
}

- (void)decorateComplexPicture:(ComplexPictureOwner *)owner {
    
    _owner = owner;
    
    if (_image) {
        owner.imageScaleConstraint = [self addScaleConstraintToView:owner.imageView];
        
        owner.image = _image;
    } else {
        NSLog(@"Warning: the owner sent to decorator isn't with a image");
    }
    
    if (_phoneType && _phoneType.length > 0) {
        _owner.phoneTypeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"phone_type_%@", _phoneType]];
    }
    
}

- (NSLayoutConstraint *)addScaleConstraintToView:(UIView *)view {
    NSLayoutConstraint *scaleConstraint = [NSLayoutConstraint
                                           constraintWithItem:view attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:view attribute:NSLayoutAttributeHeight
                                           multiplier:_scale constant:0.0f];
    [view addConstraint:scaleConstraint];
    return scaleConstraint;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    _size = image.size;
    _scale = _size.width/_size.height;
    
    if (![_images containsObject:image]) {
        [_images addObject:image];
    }
    
    if (_owner) {
        [_owner.imageView removeConstraint:_owner.imageScaleConstraint];
        _owner.imageScaleConstraint = [self addScaleConstraintToView:_owner.imageView];
    }
    
}

- (void)setSelectedPhoneType:(NSInteger)selectedPhoneType {
    
    self.phoneType = [@"iPhone " stringByAppendingString:_shownPhoneTypes[selectedPhoneType]];
    _selectedPhoneType = selectedPhoneType;
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
