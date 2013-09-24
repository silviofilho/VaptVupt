//
//  AppDelegate.h
//  VaptVupt
//
//  Created by Cainã Souza on 16/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"

@class OrgaosViewController;
@class LoginViewController;

@interface VaptVuptAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) OrgaosViewController *orgaosViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSString *deviceToken;
@property (strong, nonatomic) NSString *baseURL;

@end
