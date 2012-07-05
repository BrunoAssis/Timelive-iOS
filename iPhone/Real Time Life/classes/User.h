//
//  User.h
//  Timelive
//
//  Created by Ádamo Morone on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSInteger   Id;
    NSString*   Name;
}

@property (nonatomic, assign)   NSInteger    Id;
@property (nonatomic, copy)     NSString*    Name;

@end
