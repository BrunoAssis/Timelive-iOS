//
//  MapViewController.h
//  Real Time Life
//
//  Created by Ádamo Morone on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

//Define uma constante gringa para metros por milha.
#define METERS_PER_MILE 1609.344


@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
