//
//  MyAnnotation.h
//  RealTimeLife
//
//  Created by Ádamo Morone on 14/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSInteger idUser;
    NSString* title;
    NSString* subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, assign ) NSInteger idUser;

@end
