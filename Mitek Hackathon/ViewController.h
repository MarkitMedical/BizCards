//
//  ViewController.h
//  Mitek Hackathon
//
//  Created by Aryaman Sharda on 4/24/14.
//  Copyright (c) 2014 Tempest Vision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPassword;
    
    IBOutlet UIButton *signIn;
}
-(IBAction)signIn;
@end
