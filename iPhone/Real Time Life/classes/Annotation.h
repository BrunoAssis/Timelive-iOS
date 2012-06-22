//
//  Annotation.h
//  Real Time Life
//
//  Created by Adamo Morone Nunes on 16/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D  coordinate;
    NSInteger               idUser; //New Attribute
    NSString*               title;
    NSString*               username;
}

@property (nonatomic, assign)   CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)     NSString* title;
@property (nonatomic, copy)     NSString* username;
@property (nonatomic, assign)   NSInteger idUser;

@end
