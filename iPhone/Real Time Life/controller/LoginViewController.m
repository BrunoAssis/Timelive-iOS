//
//  LoginViewController.m
//  ;
//
//  Created by Ádamo Morone on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Facebook.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize facebook;
@synthesize facebookLogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.facebook = [appDelegate facebook];
    
    [self.facebookLogin addTarget:self action:@selector(LoginFacebook) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)viewDidUnload
{
    [self setFacebookLogin:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

      
-(void) LoginFacebook{
    [self.facebook authorize:nil];
}



@end
