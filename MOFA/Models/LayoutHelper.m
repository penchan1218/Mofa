//
//  LayoutHelper.m
//  TimeHut
//
//  Created by xujiyuan on 14/11/25.
//
//

#import "LayoutHelper.h"
#import <PureLayout/ALView+PureLayout.h>
#import "UIViewAdditions.h"

@implementation UIView (LayoutHelper)

- (void)removeMyConstraintsRelatedToSuperView
{
    NSMutableArray *constraintToRemove = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.secondItem == self || constraint.firstItem == self) {
            [constraintToRemove addObject:constraint];
        }
    }
    [self.superview removeConstraints:constraintToRemove];
}

- (NSLayoutConstraint *)fixedConstraintWithAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.secondItem == nil &&
            constraint.firstAttribute == attribute &&
            constraint.relation == NSLayoutRelationEqual) {
            
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)fixedWidthConstraint
{
    return [self fixedConstraintWithAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)fixedHeightConstraint
{
    return [self fixedConstraintWithAttribute:NSLayoutAttributeHeight];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSLayoutConstraint *)fixedRelatedConstraintWithAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self &&
            constraint.firstAttribute == attribute &&
            constraint.relation == NSLayoutRelationEqual) {
            
            return constraint;
        } else if (constraint.secondItem == self &&
                   constraint.secondAttribute == attribute &&
                   constraint.relation == NSLayoutRelationEqual) {
            
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)fixedLeadingConstraint
{
    return [self fixedRelatedConstraintWithAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)fixedTrailingConstraint
{
    return [self fixedRelatedConstraintWithAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)fixedTopConstraint
{
    return [self fixedRelatedConstraintWithAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)fixedBottomConstraint
{
    return [self fixedRelatedConstraintWithAttribute:NSLayoutAttributeBottom];
}

// greater constraints

- (NSLayoutConstraint *)greaterBottomConstraint
{
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self &&
            constraint.firstAttribute == NSLayoutAttributeBottom &&
            constraint.relation == NSLayoutRelationLessThanOrEqual) {
            
            return constraint;
        } else if (constraint.secondItem == self &&
                   constraint.secondAttribute == NSLayoutAttributeBottom &&
                   constraint.relation == NSLayoutRelationGreaterThanOrEqual) {
            
            return constraint;
        }
    }
    return nil;
}

// PureLayout extension

- (void)autoSetCurrentDimensions
{
    [self autoSetDimensionsToSize:self.frame.size];
}

- (void)autoPinCurrentOriginToTopLeft
{
    [self autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.top];
    [self autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:self.left];
}

- (void)autoPinCurrentOriginToTopRight
{
    [self autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.top];
    [self autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset: self.superview.width - self.right];
}

- (void)autoPinCurrentOriginToBottomRight
{
    [self autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:self.superview.height - self.bottom];
    [self autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset: self.superview.width - self.right];
}

- (void)autoSetLayoutWithCurrentFrame
{
    [self autoSetCurrentDimensions];
    [self autoPinCurrentOriginToTopLeft];
}

#pragma mar -

- (void)autoPinEdgesToSuperView
{
    [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)autoPinEdgesToSuperViewExcluding:(ALEdge)edge
{
    [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:edge];
}

- (void)autoMatchWidthTo:(UIView *)view
{
    [self autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:view];
}

- (void)autoMatchHeightTo:(UIView *)view
{
    [self autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:view];
}

- (void)autoSetWidth:(CGFloat)width
{
    if (self.fixedWidthConstraint) {
        self.fixedWidthConstraint.constant = width;
    } else {
        [self autoSetDimension:ALDimensionWidth toSize:width];
    }
}

- (void)autoSetHeight:(CGFloat)height
{
    if (self.fixedHeightConstraint) {
        self.fixedHeightConstraint.constant = height;
    } else {
        [self autoSetDimension:ALDimensionHeight toSize:height];
    }
}

@end
