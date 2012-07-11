//
//  ProfileViewController.m
//  Timelive
//
//  Created by Ádamo Morone on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


@synthesize facebook;
@synthesize lblUserName;
@synthesize logout;

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
    
    [self.facebook requestWithGraphPath:@"me" andDelegate:self];
    
    [self.logout addTarget:self action:@selector(LogoutAccount) forControlEvents:UIControlEventTouchUpInside];

    NSLog(@"Apareceu");
    
    
}

-(void)LogoutAccount{
    
    NSLog(@"Clicou para deslogar");
    [self.facebook logout];
}

- (void)viewDidUnload
{
    [self setLblUserName:nil];
    [self setLogout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
