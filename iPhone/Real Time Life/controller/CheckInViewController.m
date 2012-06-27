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
@synthesize eventMessage;
@synthesize postEvent;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.cancel setAction:@selector(BackToMap:)];
}

- (void)viewDidUnload
{
    [self setCancel:nil];
    [self setEventMessage:nil];
    [self setPostEvent:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)textFieldReturn:(id)sender{
    
    [sender resignFirstResponder];
}

//Ações que são executadas ao clicar no CANCEL
-(IBAction)BackToMap:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)PostEvent:(id)sender
{
    
    NSString *jsonRequest = @"{\"geo_latitude\":37.784181,\"geo_longitude\":-122.408488,\"message\":\"Teste Checkin\"}";
    NSLog(@"%@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"http://timelive.herokuapp.com/users/1/updates/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];  
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    //[self dismissModalViewControllerAnimated:YES];
}

@end
