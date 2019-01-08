//
//  DialogContentViewController.m
//  UIXOverlayController
//
//  Created by Guy Umbright on 5/29/11.
//  Copyright 2011 Kickstand Software. All rights reserved.
//

#import "DialogContentViewController1.h"

@implementation DialogContentViewController1
@synthesize txtsearch;
@synthesize btnsearch,btncancel;

- (id)init
{
    self = [super initWithNibName:@"DialogContent1" bundle:nil];
    if (self)
    {
        // Custom initialization
        self.view.layer.cornerRadius = 5.0f;
        
        btncancel.layer.cornerRadius = 5.0f;
        btncancel.clipsToBounds = YES;
        
        btnsearch.layer.cornerRadius = 5.0f;
        btnsearch.clipsToBounds = YES;
        
        CGRect frameRect = txtsearch.frame;
        frameRect.size.height = 35.0f;
        txtsearch.frame = frameRect;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(IBAction)onSearchClick:(id)sender
{
    if ([txtsearch.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter keyword for search!" duration:3.0f];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:txtsearch.text forKey:@"SEARCH_TEXT"];
        NSString *screenName = [[NSUserDefaults standardUserDefaults] valueForKey:@"SCREEN_NAME"];
        [[NSNotificationCenter defaultCenter] postNotificationName:screenName object:self];
        [self.overlayController1 dismissOverlay:YES];
    }
}

-(IBAction)onCancelClick:(id)sender
{
    [self.overlayController1 dismissOverlay:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    NSLog(@"disappear");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtsearch resignFirstResponder];
    return YES;
}

@end
