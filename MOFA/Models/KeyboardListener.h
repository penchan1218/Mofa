//
//  KeyboardListener.h
//  MOFA
//
//  Created by 陈颖鹏 on 15/6/1.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^completionBlock)(NSNotification *notif);

typedef enum {
    KeyboardListenerTypeWillChangeFrame,
    KeyboardListenerTypeWillShow,
    KeyboardListenerTypeWillHide
} KeyboardListenerType;

@interface KeyboardListener : NSObject

@property (atomic, assign) float keyboard_height;

+ (KeyboardListener *)sharedInstance;

- (void)setup;

- (void)registerObject:(id)object withBlock:(completionBlock)block ofKeyboardListenerType:(KeyboardListenerType)type;

//- (void)cancelObject:(id)obj ofType

@end
