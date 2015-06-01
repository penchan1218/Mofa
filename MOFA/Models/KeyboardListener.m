//
//  KeyboardListener.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/6/1.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "KeyboardListener.h"

@interface KeyboardListener ()

@property (strong, atomic) NSMutableDictionary *willChangeDic;
@property (strong, atomic) NSMutableDictionary *willShowDic;
@property (strong, atomic) NSMutableDictionary *willHideDic;

@end

@implementation KeyboardListener

static KeyboardListener *__sharedInstance;

+ (KeyboardListener *)sharedInstance {
    
    if (__sharedInstance) {
        return __sharedInstance;
    }
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        __sharedInstance = [[KeyboardListener alloc] init];
    });
    
    return __sharedInstance;
}

- (id)init {
    
    if (__sharedInstance) {
        return [KeyboardListener sharedInstance];
    }
    
    self = [super init];
    
    if (self) {
        _willChangeDic = [NSMutableDictionary dictionary];
        _willShowDic = [NSMutableDictionary dictionary];
        _willHideDic = [NSMutableDictionary dictionary];
        
        _keyboard_height = 216.0;
    }
    
    __sharedInstance = self;
    
    return self;
}

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardFrameChanged:(NSNotification *)notif {
    
}

- (void)keyboardWillShow:(NSNotification *)notif {
    
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
}

@end
