//
//  EventDetailViewController.h
//  Real Time Life
//
//  Created by Ádamo Morone on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailViewController : UIViewController
{
    Event* event;
}

@property (nonatomic) Event* event;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end
