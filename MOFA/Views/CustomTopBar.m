//
//  CustomTopBar.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/5/2.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "CustomTopBar.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@interface CustomTopBar ()

@property (strong, nonatomic) NSMutableArray *left_buttons;

@property (strong, nonatomic) NSMutableArray *right_buttons;

@property (nonatomic, assign) float left_dist;

@property (nonatomic, assign) float right_dist;

@end

@implementation CustomTopBar

- (id)init {
    return [self initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 60.0f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
