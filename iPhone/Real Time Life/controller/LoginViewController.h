//
//  LoginViewController.h
//  Timelive
//
//  Created by Ádamo Morone on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"


@interface LoginViewController : UIViewController{
    Facebook *facebook;
}
@property (weak, nonatomic) IBOutlet UIButton *facebookLogin;
@property (nonatomic, retain) Facebook *facebook;
@end
