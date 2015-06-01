//
//  LayoutHelper.h
//  TimeHut
//
//  Created by xujiyuan on 14/11/25.
//
//

#import <UIKit/UIKit.h>
#import <PureLayout/PureLayout.h>

@interface UIView (LayoutHelper)

- (void)removeMyConstraintsRelatedToSuperView;

//返回固定的约束
- (NSLayoutConstraint *)fixedWidthConstraint;
- (NSLayoutConstraint *)fixedHeightConstraint;

- (NSLayoutConstraint *)fixedLeadingConstraint;
- (NSLayoutConstraint *)fixedTrailingConstraint;
- (NSLayoutConstraint *)fixedTopConstraint;
- (NSLayoutConstraint *)fixedBottomConstraint;

- (NSLayoutConstraint *)greaterBottomConstraint;

- (void)autoSetCurrentDimensions;
- (void)autoPinCurrentOriginToTopLeft;
- (void)autoPinCurrentOriginToTopRight;
- (void)autoPinCurrentOriginToBottomRight;

// set current size and pin to top left
- (void)autoSetLayoutWithCurrentFrame;

- (void)autoPinEdgesToSuperViewExcluding:(ALEdge)edge;
- (void)autoPinEdgesToSuperView;

- (void)autoMatchWidthTo:(UIView *)view;
- (void)autoMatchHeightTo:(UIView *)view;

- (void)autoSetWidth:(CGFloat)width;
- (void)autoSetHeight:(CGFloat)height;

@end
