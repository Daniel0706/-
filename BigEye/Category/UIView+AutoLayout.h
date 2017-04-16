//
//  UIView+AutoLayout.h
//  Copyright (c) 2013 Tyler Fox
//  https://github.com/smileyborg/UIView-AutoLayout
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALEdge) {
    ALEdgeTop = 0,      // the top edge of the view
    ALEdgeLeft,         // the left edge of the view
    ALEdgeBottom,       // the bottom edge of the view
    ALEdgeRight,        // the right edge of the view
    ALEdgeLeading,      // the leading edge of the view (left edge for left-to-right languages like English, right edge for right-to-left languages like Arabic)
    ALEdgeTrailing      // the trailing edge of the view (right edge for left-to-right languages like English, left edge for right-to-left languages like Arabic)
};

typedef NS_ENUM(NSInteger, ALAxis) {
    ALAxisHorizontal = 0,   // a horizontal line through the center of the view
    ALAxisVertical,         // a vertical line through the center of the view
    ALAxisBaseline          // a horizontal line at the text baseline (not applicable to all views)
};

typedef NS_ENUM(NSInteger, ALDimension) {
    ALDimensionWidth = 0,   // the width of the view
    ALDimensionHeight       // the height of the view
};

typedef void(^ALConstraintsBlock)(void);    // a block of method calls to the UIView+AutoLayout category API


#pragma mark - UIView+AutoLayout

/**
 A category on UIView that provides a simple yet powerful interface for creating Auto Layout constraints.
 */
@interface UIView (AutoLayout)


#pragma mark Factory & Initializer Methods

/** Creates and returns a new view that does not convert the autoresizing mask into constraints. */
+ (instancetype)newAutoLayoutView;

/** Initializes and returns a new view that does not convert the autoresizing mask into constraints. */
- (instancetype)initForAutoLayout;


#pragma mark Auto Layout Convenience Methods

/** Sets the constraint priority to the given value for all constraints created using the UIView+AutoLayout category API within the given constraints block.
    NOTE: This method will have no effect (and will NOT set the priority) on constraints created or added using the SDK directly within the block! */
+ (void)autoSetPriority:(UILayoutPriority)priority forConstraints:(ALConstraintsBlock)block;


/** Removes the given constraint from the view it has been added to. */
+ (void)autoRemoveConstraint:(NSLayoutConstraint *)constraint;

/** Removes the given constraints from the views they have been added to. */
+ (void)autoRemoveConstraints:(NSArray *)constraints;

/** Removes all explicit constraints that affect the view.
    WARNING: Apple's constraint solver is not optimized for large-scale constraint changes; you may encounter major performance issues after using this method.
    NOTE: This method preserves implicit constraints, such as intrinsic content size constraints, which you usually do not want to remove. */
- (void)autoRemoveConstraintsAffectingView;

/** Removes all constraints that affect the view, optionally including implicit constraints.
    WARNING: Apple's constraint solver is not optimized for large-scale constraint changes; you may encounter major performance issues after using this method.
    NOTE: Implicit constraints are auto-generated lower priority constraints, and you usually do not want to remove these. */
- (void)autoRemoveConstraintsAffectingViewIncludingImplicitConstraints:(BOOL)shouldRemoveImplicitConstraints;

/** Recursively removes all explicit constraints that affect the view and its subviews.
    WARNING: Apple's constraint solver is not optimized for large-scale constraint changes; you may encounter major performance issues after using this method.
    NOTE: This method preserves implicit constraints, such as intrinsic content size constraints, which you usually do not want to remove. */
- (void)autoRemoveConstraintsAffectingViewAndSubviews;

/** Recursively removes all constraints from the view and its subviews, optionally including implicit constraints.
    WARNING: Apple's constraint solver is not optimized for large-scale constraint changes; you may encounter major performance issues after using this method.
    NOTE: Implicit constraints are auto-generated lower priority constraints, and you usually do not want to remove these. */
- (void)autoRemoveConstraintsAffectingViewAndSubviewsIncludingImplicitConstraints:(BOOL)shouldRemoveImplicitConstraints;


/** Centers the view in its superview. */
- (NSArray *)autoCenterInSuperview;

/** Centers the view along the given axis (horizontal or vertical) within its superview. */
- (NSLayoutConstraint *)autoCenterInSuperviewAlongAxis:(ALAxis)axis;


/** Pins the given center axis of the view to a fixed position (X or Y value, depending on axis) in the superview. */
- (NSLayoutConstraint *)autoPinCenterAxis:(ALAxis)axis toPositionInSuperview:(CGFloat)value;

/** Pins the given edge of the view to a fixed position (X or Y value, depending on edge) in the superview. */
- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toPositionInSuperview:(CGFloat)value;


/** Pins the given edge of the view to the same edge of the superview with an inset. */
- (NSLayoutConstraint *)autoPinEdgeToSuperviewEdge:(ALEdge)edge withInset:(CGFloat)inset;

/** Pins the given edge of the view to the same edge of the superview with an inset as a maximum or minimum. */
- (NSLayoutConstraint *)autoPinEdgeToSuperviewEdge:(ALEdge)edge withInset:(CGFloat)inset relation:(NSLayoutRelation)relation;

/** Pins the edges of the view to the edges of its superview with the given edge insets. */
- (NSArray *)autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets;


/** Pins an edge of the view to a given edge of another view. */
- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView;

/** Pins an edge of the view to a given edge of another view with an offset. */
- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView withOffset:(CGFloat)offset;

/** Pins an edge of the view to a given edge of another view with an offset as a maximum or minimum. */
- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;


/** Aligns an axis of the view to the same axis of another view. */
- (NSLayoutConstraint *)autoAlignAxis:(ALAxis)axis toSameAxisOfView:(UIView *)peerView;

/** Aligns an axis of the view to the same axis of another view with an offset. */
- (NSLayoutConstraint *)autoAlignAxis:(ALAxis)axis toSameAxisOfView:(UIView *)peerView withOffset:(CGFloat)offset;


/** Matches a dimension of the view to a given dimension of another view. */
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView;

/** Matches a dimension of the view to a given dimension of another view with an offset. */
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withOffset:(CGFloat)offset;

/** Matches a dimension of the view to a given dimension of another view with an offset as a maximum or minimum. */
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/** Matches a dimension of the view to a multiple of a given dimension of another view. */
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier;

/** Matches a dimension of the view to a multiple of a given dimension of another view as a maximum or minimum. */
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier relation:(NSLayoutRelation)relation;


/** Sets the view to a specific size. */
- (NSArray *)autoSetDimensionsToSize:(CGSize)size;

/** Sets the given dimension of the view to a specific size. */
- (NSLayoutConstraint *)autoSetDimension:(ALDimension)dimension toSize:(CGFloat)size;

/** Sets the given dimension of the view to a specific size as a maximum or minimum. */
- (NSLayoutConstraint *)autoSetDimension:(ALDimension)dimension toSize:(CGFloat)size relation:(NSLayoutRelation)relation;


/** Pins the top edge of the view to the top layout guide of the given view controller with an inset. */
- (NSLayoutConstraint *)autoPinToTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** Pins the bottom edge of the view to the bottom layout guide of the given view controller with an inset. */
- (NSLayoutConstraint *)autoPinToBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

@end


#pragma mark - NSArray+AutoLayout

/**
 A category on NSArray that provides a simple yet powerful interface for applying constraints to groups of views.
 */
@interface NSArray (AutoLayout)

/** Aligns views in this array to one another along a given edge. */
- (NSArray *)autoAlignViewsToEdge:(ALEdge)edge;

/** Aligns views in this array to one another along a given axis. */
- (NSArray *)autoAlignViewsToAxis:(ALAxis)axis;

/** Matches a given dimension of all the views in this array. */
- (NSArray *)autoMatchViewsDimension:(ALDimension)dimension;

/** Sets the given dimension of all the views in this array to a given size. */
- (NSArray *)autoSetViewsDimension:(ALDimension)dimension toSize:(CGFloat)size;


/** Distributes the views in this array equally along the selected axis. Views will be the same size (variable) in the dimension along the axis and will have spacing (fixed) between them. */
- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSpacing:(CGFloat)spacing alignment:(NSLayoutFormatOptions)alignment;

/** Distributes the views in this array equally along the selected axis. Views will be the same size (fixed) in the dimension along the axis and will have spacing (variable) between them. */
- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSize:(CGFloat)size alignment:(NSLayoutFormatOptions)alignment;

@end


#pragma mark - NSLayoutConstraint+AutoLayout

/**
 A category on NSLayoutConstraint that allows constraints to be easily removed.
 */
@interface NSLayoutConstraint (AutoLayout)

/** Removes the constraint from the view it has been added to. */
- (void)autoRemove;

@end
