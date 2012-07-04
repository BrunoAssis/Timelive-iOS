//
//  EventDetailViewController.m
//  Real Time Life
//
//  Created by Ádamo Morone on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"



@implementation EventDetailViewController
@synthesize lblUsername;
@synthesize lblMessage;


@synthesize done, event;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Ao carregar a tela, aponta a função BackToMap para o botão.
    [self.done setAction:@selector(BackToMap:)];
    
    
    self.lblMessage.text = event.title;
    self.lblUsername.text = event.subtitle;

    
}

- (void)viewDidUnload
{
    [self setDone:nil];
    [self setLblUsername:nil];
    [self setLblMessage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.]
}


//Ações que são executadas ao clicar no DONE
-(IBAction)BackToMap:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}



@end
