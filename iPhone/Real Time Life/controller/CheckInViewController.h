//
//  CheckInViewController.h
//  Timelive
//
//  Created by Ádamo Morone on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface CheckInViewController : UIViewController{
    UITextField *eventMessage;
    CLLocationCoordinate2D Location;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (strong, nonatomic) IBOutlet UITextField *eventMessage;
@property (weak, nonatomic) IBOutlet UIButton *postEvent;
@property (nonatomic, assign) CLLocationCoordinate2D Location;

- (IBAction)textFieldReturn:(id)sender;

@end
