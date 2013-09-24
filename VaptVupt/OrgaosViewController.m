//
//  OrgaosViewController.m
//  VaptVupt
//
//  Created by Cainã Souza on 22/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import "OrgaosViewController.h"

@interface OrgaosViewController () <GMGridViewDataSource, GMGridViewActionDelegate>

@end

@implementation OrgaosViewController

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
    
    _gridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 0, 320, _gridContainerView.frame.size.height)];
    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gridView.backgroundColor = [UIColor clearColor];
    [_gridContainerView addSubview:_gridView];
    _gridView.style = GMGridViewStyleSwap;
    _gridView.itemSpacing = 5;
    _gridView.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    _gridView.centerGrid = NO;
    _gridView.actionDelegate = self;
    _gridView.dataSource = self;
    _gridView.mainSuperView = self.view;
    
    //[[LocationManager sharedInstance] start];
    
    //[self getListaDeOrgaos];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self getListaDeOrgaos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - self methods



- (void)getListaDeOrgaos
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    if ([reach isReachable])
    {
        [SVProgressHUD showWithStatus:@"Carregando"];
        
        NSString *theBody = [NSString stringWithFormat:@"deviceid=%@&lat=%f&long=%f",[[NSUserDefaults standardUserDefaults] stringForKey:@"devicetoken"],[[LocationManager sharedInstance] currentLocation].coordinate.latitude,[[LocationManager sharedInstance] currentLocation].coordinate.longitude];
        NSData *bodyData = [theBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/vvv/rest/usuario/orgaos", BASE_URL]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:bodyData];
        
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
#ifdef DEBUG_MODE
                                                          //  NSLog(@"%@",[(NSDictionary *)JSON objectForKey:@"AuthResponse"]);
#endif
                                                            _orgaosArray = [[NSMutableArray alloc] initWithArray:[[(NSDictionary *)JSON objectForKey:@"AuthResponse"] objectForKey:@"orgaos"]];
                                                            [(VaptVuptAppDelegate *)[UIApplication sharedApplication].delegate setBaseURL:[[(NSDictionary *)JSON objectForKey:@"AuthResponse"] objectForKey:@"urlPadrao"]];
                                                            
                                                            [_gridView reloadData];
                                                            
                                                            [SVProgressHUD dismiss];
                                                            
                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                            
                                                            [SVProgressHUD dismiss];
                                                            [_errorView setHidden:NO];
                                                            [_gridContainerView setHidden:YES];
                                                        }];
        
        [operation start];
    }else{
        [_gridContainerView setHidden:YES];
        [_errorView setHidden:NO];
    }
    
}

- (IBAction)recarregarOrgaos
{
    [_errorView setHidden:YES];
    [_gridContainerView setHidden:NO];
    [self getListaDeOrgaos];
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [_orgaosArray count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(100, 90);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[[GMGridViewCell alloc] init] autorelease];

        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)] autorelease];
        view.backgroundColor = [UIColor clearColor];
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView *orgaoLogo = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 85)] autorelease];
    [orgaoLogo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[(VaptVuptAppDelegate *)[UIApplication sharedApplication].delegate baseURL], [[_orgaosArray objectAtIndex:index] objectForKey:@"icone"]]] placeholderImage:[UIImage imageNamed:@"OrgaoPlaceholder"]];

    [cell.contentView addSubview:orgaoLogo];
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    NSLog(@"Tocou na index %d", position);
    
    ServicosViewController *servicosViewController = [[ServicosViewController alloc] initWithNibName:@"ServicosViewController" bundle:nil];
    [servicosViewController setServicosArray:[[_orgaosArray objectAtIndex:position] objectForKey:@"servicos"]];
    servicosViewController.mode = MMReachabilityModeOverlay;
    
    [self.navigationController pushViewController:servicosViewController animated:YES];
    
    [servicosViewController release];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tocou em espaço vazio");
}

- (void)dealloc {
    [_imgRodape release];
    [_imgTopo release];
    [_wind release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImgRodape:nil];
    [self setImgTopo:nil];
    [self setWind:nil];
    [super viewDidUnload];
}
@end
