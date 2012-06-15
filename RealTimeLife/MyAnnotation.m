//
//  MyAnnotation.m
//  RealTimeLife
//
//  Created by Ádamo Morone on 14/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize idUser;

- (void) dealloc
{
    //[super dealloc];
    self.title = nil;
    self.subtitle = nil;
    self.idUser = 0;
}

@end
