//
//  CheckInViewController.m
//  Timelive
//
//  Created by Ádamo Morone on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()

@end

@implementation CheckInViewController
@synthesize cancel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    [self.cancel setAction:@selector(BackToMap:)];
}

- (void)viewDidUnload
{
    [self setCancel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//Ações que são executadas ao clicar no CANCEL
-(IBAction)BackToMap:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
