//
//  ServicoViewController.m
//  VaptVupt
//
//  Created by Cainã Souza on 22/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import "ServicoViewController.h"

@interface ServicoViewController (){
    NJKWebViewProgress *_progressProxy;
}

- (IBAction)loadURLInWebView;

@end

@implementation ServicoViewController

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
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadURLInWebView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)loadURLInWebView
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    [_webView setHidden:NO];
    [_errorView setHidden:YES];

    if ([reach isReachable])
    {
        NSString *url = [NSString stringWithFormat:@"%@/%@",BASE_URL,[_servicoInformacoes objectForKey:@"url"]];
        
        NSURL *nsUrl = [NSURL URLWithString:url];
        
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
        
        [_webView loadRequest:request];
    }else{
        [_webView setHidden:YES];
        [_errorView setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [_progressView setProgress:progress animated:NO];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *extensao = [request.URL.absoluteString substringFromIndex:[request.URL.absoluteString length]-4];

    if ([extensao isEqualToString:@".pdf"]){
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }else{
        return YES;
    }
}

@end
