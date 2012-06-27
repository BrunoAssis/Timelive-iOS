//
//  CheckInViewController.h
//  Timelive
//
//  Created by Ádamo Morone on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInViewController : UIViewController{
    UITextField *eventMessage;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (strong, nonatomic) IBOutlet UITextField *eventMessage;
@property (weak, nonatomic) IBOutlet UIButton *postEvent;

- (IBAction)textFieldReturn:(id)sender;

@end
