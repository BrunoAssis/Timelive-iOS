//
//  Annotation.h
//  Real Time Life
//
//  Created by Adamo Morone Nunes on 16/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Event : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D  coordinate;
    NSInteger               idUser;
    NSInteger               idUpdate;
    NSString*               title;
    NSString*               subtitle;
    
}

@property (nonatomic, assign)   CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)     NSString* title;
@property (nonatomic, copy)     NSString* subtitle;
@property (nonatomic, assign)   NSInteger idUser;
@property (nonatomic, assign)   NSInteger idUpdate;

@end
