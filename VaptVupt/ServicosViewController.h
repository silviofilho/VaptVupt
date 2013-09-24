//
//  ServicosViewController.h
//  VaptVupt
//
//  Created by Cainã Souza on 22/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicoViewController.h"

@interface ServicosViewController : MMReachabilityViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *servicosArray;

- (IBAction)popViewController:(id)sender;

@end
