//
//  ServicoViewController.h
//  VaptVupt
//
//  Created by Cainã Souza on 22/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "NJKWebViewProgress.h"
#import "Reachability.h"

@interface ServicoViewController : UIViewController <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, retain) NSDictionary *servicoInformacoes;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIView *errorView;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;

- (IBAction)popViewController:(id)sender;

@end
