//
//  OverlayController.h
//  NextiPad
//
//  Created by gumbright on 8/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIXOverlayContentViewController1;

@class UIXOverlayController1;

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
@interface UIXOverlayMaskView1 : UIView
{
	
}

@end


@protocol UIXOverlayController1Delegate

//??overlay will appear
//??overlay did disappear
//??overlay mask touched

@optional

- (void) overlayWillDisplayContent:(UIXOverlayController1*) overlayController;
- (void) overlayContentDisplayed:(UIXOverlayController1*) overlayController;
- (void) overlayMaskTouched:(UIXOverlayController1*) overlayController;

@required

- (void) overlayRemoved1:(UIXOverlayController1*) overlayController;

@end

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
@interface UIXOverlayController1 : NSObject
{
	UIView* _parent;
	UIViewController* _contentController;
	
	NSObject<UIXOverlayController1Delegate>* __weak overlayDelegate;
	
	UIXOverlayMaskView1* maskView;
}

- (void) presentOverlayOnView:(UIView*) parent 
                  withContent:(UIXOverlayContentViewController1 *) contentController
                     animated:(BOOL) animated;
- (void) dismissOverlay:(BOOL) animated;
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@property (nonatomic, strong, readonly)  UIView* parent;
@property (assign) BOOL dismissUponTouchMask;

@property (nonatomic, strong) UIColor* maskColor;

@property (nonatomic, weak) NSObject<UIXOverlayController1Delegate>* overlayDelegate;

@end

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
@interface UIXOverlayContentViewController1 : UIViewController
{
}

@property (nonatomic, strong) UIXOverlayController1 *overlayController1;

@end
