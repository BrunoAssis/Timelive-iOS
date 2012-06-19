//
//  EventDetailViewController.m
//  Real Time Life
//
//  Created by Ádamo Morone on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController
@synthesize done;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Ao carregar a tela, aponta a função BackToMap para o botão.
    [self.done setAction:@selector(BackToMap:)];
    
}

- (void)viewDidUnload
{
    [self setDone:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.]
}


//Ações que são executadas ao clicar no DONE
-(IBAction)BackToMap:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
