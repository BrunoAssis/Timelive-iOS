//
//  Annotation.m
//  Real Time Life
//
//  Created by Adamo Morone Nunes on 16/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event


@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize idUser;
@synthesize idUpdate;

- (void) dealloc
{
    //[super dealloc];
    self.title = nil;
    self.subtitle = nil;
    self.idUser = 0;
    self.idUpdate = 0;
}

@end
