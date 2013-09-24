//
//  OrgaosViewController.h
//  VaptVupt
//
//  Created by Cainã Souza on 22/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VaptVuptAppDelegate.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "LocationManager.h"
#import "Global.h"
#import "ServicosViewController.h"
#import "GMGridView.h"
#import "Reachability.h"

@interface OrgaosViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIView *wind;

@property (strong, nonatomic) IBOutlet UIView *gridContainerView;
@property (strong, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) GMGridView *gridView;
@property (strong, nonatomic) IBOutlet UILabel *mensagemDeErroLabel;
@property (strong, nonatomic) IBOutlet UIButton *recarregarButton;
@property (retain, nonatomic) NSMutableArray *orgaosArray;
@property (retain, nonatomic) IBOutlet UIImageView *imgTopo;
@property (retain, nonatomic) IBOutlet UIImageView *imgRodape;

- (IBAction)recarregarOrgaos;

@end
