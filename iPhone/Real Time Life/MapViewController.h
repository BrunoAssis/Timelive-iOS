//
//  MapViewController.h
//  Real Time Life
//
//  Created by Adamo Morone Nunes on 16/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

//Define uma constante gringa para metros por milha.
#define METERS_PER_MILE 1609.344


@class DetailEventViewController;

@interface MapViewController : UIViewController{
    
    DetailEventViewController *detailEvent;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) DetailEventViewController *detailEvent;



@end
