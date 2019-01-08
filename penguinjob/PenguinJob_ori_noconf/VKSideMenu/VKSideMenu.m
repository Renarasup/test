//
//  VKSideMenu.m
//  Version: 1.1
//
//  Created by Vladislav Kovalyov on 2/7/16.
//  Copyright © 2016 WOOPSS.com (http://woopss.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VKSideMenu.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define ROOTVC [[[[UIApplication sharedApplication] delegate] window] rootViewController]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation VKSideMenuItem

@synthesize icon;
@synthesize title;
@synthesize tag;

@end

@interface VKSideMenu() <UITableViewDelegate, UITableViewDataSource>
{
    UITapGestureRecognizer *tapGesture;
}

@property (nonatomic, strong) UIView *overlay;

@end

@implementation VKSideMenu

#pragma mark - Initialization

-(instancetype)init
{
    if (self = [super init])
    {
        [self baseInit];
    }
    
    return self;
}

-(instancetype)initWithDirection:(VKSideMenuDirection)direction
{
    if (self = [super init])
    {
        [self baseInit];
        
        self.direction  = direction;
    }
    
    return self;
}

-(instancetype)initWithSize:(CGFloat)size andDirection:(VKSideMenuDirection)direction
{
    if (self = [super init])
    {
        [self baseInit];
        
        self.size       = size;
        self.direction  = direction;
    }
    
    return self;
}

-(void)baseInit
{
    self.size                       = 220;
    self.direction                  = VKSideMenuDirectionFromLeft;
    self.rowHeight                  = 44;
    self.enableOverlay              = YES;
    self.automaticallyDeselectRow   = YES;
    self.hideOnSelection            = YES;
    self.enableGestures             = YES;
    
    self.sectionTitleFont   = [UIFont systemFontOfSize:15.];
    self.selectionColor     = [UIColor colorWithWhite:1. alpha:.5];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //self.backgroundColor    = [UIColor colorWithWhite:1. alpha:.8];
#pragma clang diagnostic pop
    self.textColor          = UIColorFromRGB(0x252525);
    self.iconsColor         = [UIColor blackColor];
    self.sectionTitleColor  = UIColorFromRGB(0x8f8f8f);
    
    if(!SYSTEM_VERSION_LESS_THAN(@"8.0"))
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
}

-(void)initViews
{
    // Setup overlay
    self.overlay = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlay.alpha = 0;
    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    if (self.enableOverlay)
        self.overlay.backgroundColor = [UIColor colorWithWhite:0. alpha:.4];
    
    // Setup gestures
    if (self.enableGestures)
    {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self.overlay addGestureRecognizer:tapGesture];
    }
    
//     Setup frame before show
    
//    if (self.direction == VKSideMenuDirectionFromTop || self.direction == VKSideMenuDirectionFromBottom)
//    {
//        // Calculate table view height for vertical directions (fromTop and fromBottom)
//        self.tableViewHeight = 20;
//        NSInteger numberOfSections = [self.dataSource numberOfSectionsInSideMenu:self];
//        
//        for (int section; section < numberOfSections; section++)
//        {
//            self.tableViewHeight += [self.dataSource sideMenu:self numberOfRowsInSection:section] * self.rowHeight;
//            
//            if ([self.delegate sideMenu:self titleForHeaderInSection:section].length > 0)
//                self.tableViewHeight += [self.tableView sectionHeaderHeight];
//        }
//    }
    
    CGRect frame = [self frameHidden];
    
    if(SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        self.view = [[UIView alloc] initWithFrame:frame];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.view.backgroundColor = self.backgroundColor;
#pragma clang diagnostic pop
    }
    else
    {
        if (@available(iOS 10.0, *)) {
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
            self.view = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        } else {
            // Fallback on earlier versions
        }
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F9FA"];
    }
    
    //1.Menu Logo
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(10,30,80,80)];
        CGFloat cornerRadius = container.frame.size.height/2.0f;
        container.layer.shadowOffset = CGSizeMake(0, 0);
        container.layer.shadowOpacity = 0.8;
        container.layer.shadowRadius = 5.0;
        container.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        container.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:container.bounds cornerRadius:cornerRadius] CGPath];
        
        //1.User Profile Image
        UIImageView *logo =[[UIImageView alloc] init];
        //logo.contentMode = UIViewContentModeScaleAspectFit;
        logo.layer.borderWidth = 0.5f;
        logo.layer.borderColor = [UIColor darkGrayColor].CGColor;
        NSArray *ProfileArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileArray"];
        NSString *str = [[ProfileArray valueForKey:@"user_image"] componentsJoinedByString:@","];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *ImageUrl = [NSURL URLWithString:encodedString];
        NSString *placeImage = [NSString stringWithFormat:@"%@images/11129_user.jpg",[CommonUtils getBaseURL]];
        NSString *encodedStringStr = [placeImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *placeImageUrl = [NSURL URLWithString:encodedStringStr];
        NSData *data = [NSData dataWithContentsOfURL:placeImageUrl];
        UIImage *imagea = [UIImage imageWithData:data];
        [logo sd_setImageWithURL:ImageUrl placeholderImage:imagea];
        logo.layer.cornerRadius = cornerRadius;
        logo.layer.masksToBounds = YES;
        logo.frame = container.bounds;
        [container addSubview:logo];
        [[(UIVisualEffectView *)self.view contentView] addSubview:container];
        
        //2.User Name
        UILabel *lblname = [[UILabel alloc] initWithFrame:CGRectMake(105,35,self.view.frame.size.width-120,40)];
        lblname.text = [[ProfileArray valueForKey:@"name"] componentsJoinedByString:@","];
        lblname.textAlignment = NSTextAlignmentLeft;
        lblname.font = [UIFont fontWithName:@"Lato-Bold" size:25.0f];
        lblname.textColor = [UIColor blackColor];
        lblname.backgroundColor = [UIColor clearColor];
        [[(UIVisualEffectView *)self.view contentView] addSubview:lblname];
        
        //3.User Email
        UILabel *lbluser = [[UILabel alloc] initWithFrame:CGRectMake(105,65,self.view.frame.size.width-120,40)];
        lbluser.text = [[ProfileArray valueForKey:@"email"] componentsJoinedByString:@","];
        lbluser.textAlignment = NSTextAlignmentLeft;
        lbluser.font = [UIFont fontWithName:@"Lato-Regular" size:18.0f];
        lbluser.textColor = [UIColor darkGrayColor];
        lbluser.backgroundColor = [UIColor clearColor];
        [[(UIVisualEffectView *)self.view contentView] addSubview:lbluser];
        
        //4.Line
        UILabel *lblline = [[UILabel alloc] initWithFrame:CGRectMake(0,140,self.view.frame.size.width,0.5)];
        lblline.backgroundColor = [UIColor lightGrayColor];
        [[(UIVisualEffectView *)self.view contentView] addSubview:lblline];
    } else {
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(10,30,80,80)];
        CGFloat cornerRadius = container.frame.size.height/2.0f;
        container.layer.shadowOffset = CGSizeMake(0, 0);
        container.layer.shadowOpacity = 0.8;
        container.layer.shadowRadius = 5.0;
        container.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        container.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:container.bounds cornerRadius:cornerRadius] CGPath];
        UIImageView *logo =[[UIImageView alloc] init];
        //logo.contentMode = UIViewContentModeScaleAspectFit;
        logo.layer.borderWidth = 0.5f;
        logo.layer.borderColor = [UIColor darkGrayColor].CGColor;
        logo.image=[UIImage imageNamed:@"menulogo"];
        logo.layer.cornerRadius = cornerRadius;
        logo.layer.masksToBounds = YES;
        logo.frame = container.bounds;
        [container addSubview:logo];
        [[(UIVisualEffectView *)self.view contentView] addSubview:container];
        
        //2.User Name
        UILabel *lblname = [[UILabel alloc] initWithFrame:CGRectMake(105,35,self.view.frame.size.width-120,40)];
        lblname.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        lblname.textAlignment = NSTextAlignmentLeft;
        lblname.font = [UIFont fontWithName:@"Lato-Bold" size:25.0f];
        lblname.textColor = [UIColor blackColor];
        lblname.backgroundColor = [UIColor clearColor];
        [[(UIVisualEffectView *)self.view contentView] addSubview:lblname];
        
        //3.User Email
        UILabel *lbluser = [[UILabel alloc] initWithFrame:CGRectMake(105,65,self.view.frame.size.width-120,40)];
        lbluser.text = @"";
        lbluser.textAlignment = NSTextAlignmentLeft;
        lbluser.font = [UIFont fontWithName:@"Lato-Regular" size:18.0f];
        lbluser.textColor = [UIColor darkGrayColor];
        lbluser.backgroundColor = [UIColor clearColor];
        [[(UIVisualEffectView *)self.view contentView] addSubview:lbluser];
        
        //4.Line
        UILabel *lblline = [[UILabel alloc] initWithFrame:CGRectMake(0,140,self.view.frame.size.width,0.5)];
        lblline.backgroundColor = [UIColor lightGrayColor];
        [[(UIVisualEffectView *)self.view contentView] addSubview:lblline];
    }
    

    
    //5.Setup Tableview Position
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-195) style:UITableViewStylePlain];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.separatorColor   = [UIColor clearColor];
    self.tableView.backgroundColor  = [UIColor clearColor];
    self.tableView.scrollEnabled = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [[(UIVisualEffectView *)self.view contentView] addSubview:self.tableView];
    
    //4.Developed By
    UILabel *lbldeveloped = [[UILabel alloc] initWithFrame:CGRectMake(-1,150+self.tableView.frame.size.height,self.view.frame.size.width+2,51)];
    lbldeveloped.text = [CommonUtils ChangeAppDevelopedBy];
    lbldeveloped.layer.borderWidth = 0.5f;
    lbldeveloped.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lbldeveloped.textAlignment = NSTextAlignmentCenter;
    lbldeveloped.font = [UIFont fontWithName:@"OpenSans-Semibold" size:16.0f];
    lbldeveloped.textColor = [UIColor darkGrayColor];
    [[(UIVisualEffectView *)self.view contentView] addSubview:lbldeveloped];
}

#pragma mark - Appearance
-(void)show
{
    [self initViews];
    
    [ROOTVC.view addSubview:self.overlay];
    [ROOTVC.view addSubview:self.view];
    
    CGRect frame = [self frameShowed];
    
    [UIView animateWithDuration:0.275 animations:^
     {
         self.view.frame = frame;
         self.overlay.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         if (_delegate && [_delegate respondsToSelector:@selector(sideMenuDidShow:)])
             [_delegate sideMenuDidShow:self];
     }];
}

-(void)showWithSize:(CGFloat)size
{
    self.size = size;
    [self show];
}

-(void)hide
{
    [UIView animateWithDuration:0.275 animations:^
     {
         self.view.frame = [self frameHidden];
         self.overlay.alpha = 0.;
     }
                     completion:^(BOOL finished)
     {
         if (_delegate && [_delegate respondsToSelector:@selector(sideMenuDidHide:)])
             [_delegate sideMenuDidHide:self];
         
         [self.view removeFromSuperview];
         [self.overlay removeFromSuperview];
         [self.overlay removeGestureRecognizer:tapGesture];
         
         self.overlay = nil;
         self.tableView = nil;
         self.view = nil;
     }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource numberOfSectionsInSideMenu:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource sideMenu:self numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIImageView *imageViewIcon;
    UILabel *title;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:self.selectionColor];
        [cell setSelectedBackgroundView:bgColorView];
    }
    
    VKSideMenuItem *item = [self.dataSource sideMenu:self itemForRowAtIndexPath:indexPath];
    
    CGFloat contentHeight = cell.frame.size.height * .8;
    CGFloat contentTopBottomPadding = cell.frame.size.height * .1;
    
    if (item.icon)
    {
        imageViewIcon = [cell.contentView viewWithTag:100];
        
        if (!imageViewIcon)
        {
            imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, contentTopBottomPadding+5, contentHeight-10, contentHeight-10)];
            imageViewIcon.tag = 100;
            [cell.contentView addSubview:imageViewIcon];
        }
        
        imageViewIcon.image = item.icon;
        
        if (self.iconsColor)
        {
            imageViewIcon.image = [imageViewIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            imageViewIcon.tintColor = self.iconsColor;
        }
    }
    
    title = [cell.contentView viewWithTag:200];
    
    if (!title)
    {
        CGFloat titleX = item.icon ? CGRectGetMaxX(imageViewIcon.frame) + 12 : 12;
        title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, contentTopBottomPadding, cell.frame.size.width - titleX - 12, contentHeight)];
        title.tag  = 200;
        title.font = [UIFont fontWithName:@"OpenSans-Regular" size:18.0f];
        title.textColor = [UIColor blackColor];
        title.adjustsFontSizeToFitWidth = YES;
        [cell.contentView addSubview:title];
    }
    
    title.text      = item.title;
    //title.textColor = self.textColor;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(sideMenu:didSelectRowAtIndexPath:)])
        [_delegate sideMenu:self didSelectRowAtIndexPath:indexPath];
    
    if (self.automaticallyDeselectRow)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.hideOnSelection)
        [self hide];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sideMenu:titleForHeaderInSection:)])
        return [self.delegate sideMenu:self titleForHeaderInSection:section].uppercaseString;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:self.sectionTitleColor];
    [header.textLabel setFont:self.sectionTitleFont];
}

#pragma mark - GestureRecognition

-(void)addSwipeGestureRecognition:(UIView *)view
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwap:)];
    
    switch (self.direction)
    {
        case VKSideMenuDirectionFromTop:
            swipe.direction = UISwipeGestureRecognizerDirectionDown;
            break;
            
        case VKSideMenuDirectionFromLeft:
            swipe.direction = UISwipeGestureRecognizerDirectionRight;
            break;

            
        case VKSideMenuDirectionFromBottom:
            swipe.direction = UISwipeGestureRecognizerDirectionUp;
            break;

            
        case VKSideMenuDirectionFromRight:
            swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            break;
    }
    
    [view addGestureRecognizer:swipe];
}

-(void)didTap:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
        [self hide];
}

-(void)didSwap:(UISwipeGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded && self.enableGestures)
        [self showWithSize:self.size];
}

#pragma mark - Helpers

-(CGRect)frameHidden
{
    CGRect frame = CGRectZero;
    
    switch (self.direction)
    {
        case VKSideMenuDirectionFromTop:
            frame = CGRectMake(0, -self.size, [UIScreen mainScreen].bounds.size.width, self.size);
            break;
            
        case VKSideMenuDirectionFromLeft:
            frame = CGRectMake(-self.size, 0, self.size, [UIScreen mainScreen].bounds.size.height);
            break;
            
        case VKSideMenuDirectionFromBottom:
            frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.size);
            break;
            
        case VKSideMenuDirectionFromRight:
            frame = CGRectMake([UIScreen mainScreen].bounds.size.width + self.size, 0, self.size, [UIScreen mainScreen].bounds.size.height);
            break;
    }
    
    return frame;
}

-(CGRect)frameShowed
{
    CGRect frame = self.view.frame;
    
    switch (self.direction)
    {
        case VKSideMenuDirectionFromTop:
            frame.origin.y = 0;
            break;
            
        case VKSideMenuDirectionFromLeft:
            frame.origin.x = 0;
            break;
            
        case VKSideMenuDirectionFromBottom:
            frame.origin.y = [UIScreen mainScreen].bounds.size.height - self.size;
            break;
            
        case VKSideMenuDirectionFromRight:
            frame.origin.x = [UIScreen mainScreen].bounds.size.width - self.size;
            break;
    }
    
    return frame;
}

@end
