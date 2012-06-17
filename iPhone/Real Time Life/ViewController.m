//
//  ViewController.m
//  Real Time Life
//
//  Created by Adamo Morone Nunes on 16/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DetailEventViewController.h"
#import "MapViewController.h"



@interface ViewController ()

@end


@implementation ViewController


@synthesize mapViewController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MapViewController *mapView = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    self.mapViewController = mapView;
    [self.view addSubview:self.mapViewController.view];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
