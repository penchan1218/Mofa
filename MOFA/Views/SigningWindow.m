//
//  SigningWindow.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/5/31.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "SigningWindow.h"
#import "LayoutHelper.h"

@interface SigningWindow () <UITextFieldDelegate> {
    id<UIApplicationDelegate> __appDelegate;
    UIWindow *__mainWindow;
    BOOL on;
}

@property (weak, nonatomic) UIView *background;

@property (weak, nonatomic) UIView *dialogue;

@property (weak, nonatomic) UILabel *placeholder;

@property (weak, nonatomic) UITextField *inputTf;

@property (weak, nonatomic) UIView *cancelBtn;

@property (weak, nonatomic) UIView *confirmBtn;

@end

@implementation SigningWindow

- (id)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        self.alpha = 0.0f;
        self.backgroundColor = [UIColor clearColor];
        
        __appDelegate = [UIApplication sharedApplication].delegate;
        __mainWindow = __appDelegate.window;
        on = NO;
        
        [self addKeyboardNotifications];
        [self setupUI];
    }
    
    return self;
}

- (void)addKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameChanged:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardFrameChanged:(NSNotification *)notif {
    
}

- (void)setupUI {
    UIView *background = [UIView newAutoLayoutView];
    background.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    [self addSubview:background];
    
    [background autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    _background = background;
    
    UIView *dialogue = [UIView newAutoLayoutView];
    dialogue.backgroundColor = [UIColor whiteColor];
    [self addSubview:dialogue];
    
    float dialogueScale = 580.0/234;
    [dialogue autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:dialogue withMultiplier:dialogueScale];
    [dialogue autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 42, SCREEN_SIZE.height/2, 42) excludingEdge:ALEdgeTop];
    _dialogue = dialogue;
    
    
    
    float innerScale = 120.0/234;
    UIView *topPart = [UIView newAutoLayoutView];
    topPart.backgroundColor = UIColorFromRGBA(75, 200, 250, 1.0);
    [dialogue addSubview:topPart];
    
    [topPart autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [topPart autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:dialogue withMultiplier:innerScale];
    
    UIView *bottomPart = [UIView newAutoLayoutView];
    bottomPart.backgroundColor = UIColorFromRGBA(34, 161, 215, 1.0);
    [dialogue addSubview:bottomPart];
    
    [bottomPart autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topPart];
    [bottomPart autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
    
    
    UILabel *tip_label = [UILabel newAutoLayoutView];
    tip_label.textColor = [UIColor whiteColor];
    tip_label.font = [UIFont systemFontOfSize:14.0];
    tip_label.textAlignment = NSTextAlignmentCenter;
    tip_label.text = @"请输入作品的摄影师名";
    [topPart addSubview:tip_label];
    _placeholder = tip_label;
    
    [tip_label autoCenterInSuperview];
    
    UITextField *inputTf = [UITextField newAutoLayoutView];
    inputTf.delegate = self;
    [topPart addSubview:inputTf];
    _inputTf = inputTf;
    
    [inputTf autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:tip_label];
    [inputTf autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [inputTf autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:dialogue];
    [inputTf autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:dialogue];
    
    
    
    UIView *separator = [UIView newAutoLayoutView];
    separator.backgroundColor = [UIColor whiteColor];
    [bottomPart addSubview:separator];
    
    [separator autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:bottomPart];
    [separator autoSetDimension:ALDimensionWidth toSize:ONE_PIXEL];
    [separator autoCenterInSuperview];
    
    UIButton *cancelBtn = [UIButton newAutoLayoutView];
    [cancelBtn setContentMode:UIViewContentModeCenter];
    [cancelBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomPart addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    
    [cancelBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTrailing];
    [cancelBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:separator];
    
    UIButton *confirmBtn = [UIButton newAutoLayoutView];
    [confirmBtn setContentMode:UIViewContentModeCenter];
    [confirmBtn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomPart addSubview:confirmBtn];
    _confirmBtn = confirmBtn;
    
    [confirmBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeading];
    [confirmBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:separator];
}

- (void)cancelBtnDidClick:(id)sender {
    [self hide];
}

- (void)confirmBtnDidClick:(id)sender {
    
}

- (void)hide {
    [self hideWithCompletionBlock:nil];
}

- (void)show {
    [self showWithCompletionBlock:nil];
}

- (void)showWithCompletionBlock:(void (^)())completionBlock {
    if (on) {
        NSLog(@"The signing window is already on!");
        return ;
    }
    
    __appDelegate.window = self;
    [self makeKeyAndVisible];
    
    [UIView animateWithDuration:0.25 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
                         
                         [_inputTf becomeFirstResponder];
                         
                         if (completionBlock) {
                             completionBlock();
                         }
                     }];
}

- (void)hideWithCompletionBlock:(void (^)())completionBlock {
    
    [UIView animateWithDuration:0.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                     } completion:^(BOOL finished) {
                         
                         __appDelegate.window = __mainWindow;
                         [__mainWindow makeKeyAndVisible];
                         
                         __mainWindow = nil;
                         __appDelegate = nil;
                         
                         if (completionBlock) {
                             completionBlock();
                         }
                         
                         [self removeKeyboardNotifications];
                         [self removeFromSuperview];
                     }];
}

#pragma mark - Protocol - textfield

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int length = (int)(textField.text.length-range.length+string.length);
    
    if (length == 0) {
        _placeholder.alpha = 1.0;
    } else {
        _placeholder.alpha = 0.0;
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
//    _dialogue.fixedBottomConstraint.constant
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;
}


@end

