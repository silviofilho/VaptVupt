//
//  LoginViewController.m
//  VaptVupt
//
//  Created by Cainã Souza on 16/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

    [_scrollView setContentSize:CGSizeMake(320, 371)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapView
{
    [self.view endEditing:YES];
}

#pragma mark
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(0, self.view.frame.origin.y, 320, self.view.frame.size.height-215)];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(0, self.view.frame.origin.y, 320, self.view.frame.size.height+215)];
}

@end
