//
//  LoginViewController.h
//  VaptVupt
//
//  Created by Cainã Souza on 16/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : MMReachabilityViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction)didTapView;

@end
