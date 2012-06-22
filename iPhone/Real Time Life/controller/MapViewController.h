//
//  MapViewController.h
//  Real Time Life
//
//  Created by Ádamo Morone on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "EventDetailViewController.h"
#import "Annotation.h"

//Define uma constante gringa para metros por milha.
#define METERS_PER_MILE 1609.344

@class EventDetailViewController;

@interface MapViewController : UIViewController{
    
    IBOutlet EventDetailViewController  *eventDetail;
    IBOutlet MKMapView                  *mapView;
    NSMutableArray                      *annotationArray;

}
@property (nonatomic, retain) IBOutlet MKMapView            *mapView;
@property (nonatomic, retain) EventDetailViewController     *eventDetail;
@property (nonatomic) NSMutableArray                        *annotationArray; //TODO: Modificar para Array

@end
