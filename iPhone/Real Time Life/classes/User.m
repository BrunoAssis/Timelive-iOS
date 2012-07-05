//
//  User.m
//  Timelive
//
//  Created by Ádamo Morone on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize Id;
@synthesize Name;


-(void) dealloc{
    self.Id     = 0;
    self.Name   = nil;
}
@end


