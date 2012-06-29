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
@synthesize Location;


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
    
    NSString *latitude = [[NSNumber numberWithFloat:self.Location.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithFloat:self.Location.longitude] stringValue];
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"geo_latitude\":%@,\"geo_longitude\":%@,\"message\":\"%@\",\"user_id\":1}", latitude, longitude, self.eventMessage.text];
    NSLog(@"%@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"http://timelive.herokuapp.com/users/1/updates.json"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];  
    [request setHTTPBody:[jsonRequest dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSMutableData *d = [NSMutableData data];
    [d appendData:data];
    
    NSString *a = [[NSString alloc] initWithData:d encoding:NSASCIIStringEncoding];
    
    NSLog(@"Data: %@", a);
}


@end
