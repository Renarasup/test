//
//  DialogContentViewController.h
//  UIXOverlayController
//
//  Created by Guy Umbright on 5/29/11.
//  Copyright 2011 Kickstand Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIXOverlayController1.h"
#import "AppDelegate.h"
#import "KSToastView.h"
#import "HexColors.h"

@interface DialogContentViewController1 : UIXOverlayContentViewController1

@property(nonatomic,retain) IBOutlet UITextField *txtsearch;
@property(nonatomic,retain) IBOutlet UIButton *btnsearch,*btncancel;

-(IBAction)onSearchClick:(id)sender;
-(IBAction)onCancelClick:(id)sender;

@end
