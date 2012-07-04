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
#import "Event.h"

//Define uma constante gringa para metros por milha.
#define METERS_PER_MILE 1609.344

@class EventDetailViewController;

@interface MapViewController : UIViewController{
    
    IBOutlet EventDetailViewController  *eventDetail;
    IBOutlet MKMapView                  *mapView;
    NSMutableArray                      *eventArray;
    CLLocationManager                   *locationManager;
    CLLocation                          *startLocation;
    CLLocationCoordinate2D              zoomLocation;
    UIButton                            *resetLocation;
    

}
@property (weak, nonatomic) IBOutlet UIBarButtonItem        *checkIn;
@property (nonatomic, retain) IBOutlet MKMapView            *mapView;
@property (nonatomic, retain) EventDetailViewController     *eventDetail;
@property (nonatomic, retain) NSMutableArray                *eventArray; //TODO: Modificar para Array
@property (nonatomic, retain) CLLocationManager             *locationManager;
@property (nonatomic, retain) CLLocation                    *startLocation;
@property (nonatomic, assign) CLLocationCoordinate2D        zoomLocation;
@property (nonatomic, retain) IBOutlet UIButton             *resetLocation;
@property (weak, nonatomic) IBOutlet UIButton               *refresh;
    





@end
