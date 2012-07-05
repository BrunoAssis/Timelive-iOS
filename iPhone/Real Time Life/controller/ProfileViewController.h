//
//  ProfileViewController.h
//  Timelive
//
//  Created by Ádamo Morone on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface ProfileViewController : UIViewController  <FBRequestDelegate>{
    Facebook    *facebook;
}
@property (weak, nonatomic) IBOutlet UILabel                *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton               *logout;
@property (nonatomic, retain) Facebook                      *facebook;
@end
