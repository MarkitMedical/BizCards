//
//  CreateAccountViewController.m
//  NameGuru
//
//  Created by Aryaman Sharda on 4/24/14.
//  Copyright (c) 2014 NameGuru. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <Parse/Parse.h>
#define kOFFSET_FOR_KEYBOARD 100.0

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)signUp
{
    if(txtPassword.text.length > 5 && txtFirstName.text.length > 0 && txtLastName.text.length > 0 && [txtEmail.text rangeOfString:@"@"].location != NSNotFound)
    {
        PFUser *user = [PFUser user];
        user.username = [NSString stringWithFormat:@"%@ %@",[txtFirstName text], [txtLastName text]];
        user.password = [txtPassword text];
        user.email =  [txtEmail text];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:txtPassword.text forKey:@"userPassword"];
                

            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@",errorString);
                // Show the errorString somewhere and let the user try again.
            }
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please review sign up credentials" message:@"Illegal characters were found. Please fill in all fields correctly." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.origin.y >= 0)
        [self setViewMoveUp:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self setViewMoveUp:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtConfirmPassword resignFirstResponder];

}

-(void)setViewMoveUp:(BOOL)moveUp{
    
    CGRect rect = self.view.frame;
    if(moveUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        
    }
    self.view.frame = rect;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end