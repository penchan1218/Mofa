//
//  ComplexPictureOwner.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/1.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ComplexPictureOwner : NSObject

@property (strong, nonatomic) IBOutlet UIView *ibView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *phoneTypeImageView;

@property (weak, nonatomic) IBOutlet UILabel *byLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) UIImage *image;

@end
