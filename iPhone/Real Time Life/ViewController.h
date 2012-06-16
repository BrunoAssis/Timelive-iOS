//
//  ViewController.h
//  Real Time Life
//
//  Created by Adamo Morone Nunes on 16/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;



@interface ViewController : UIViewController{
    MapViewController *mapViewController;
}

@property (nonatomic, retain) MapViewController *mapViewController;


@end
