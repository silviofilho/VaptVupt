//
//  ServicosViewController.m
//  VaptVupt
//
//  Created by Cainã Souza on 22/05/13.
//  Copyright (c) 2013 PapelWeb. All rights reserved.
//

#import "ServicosViewController.h"

@interface ServicosViewController ()

@end

@implementation ServicosViewController

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

    _tableView.rowHeight = 70.0f;
    
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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark
#pragma mark - UITableView delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_servicosArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ServicoCell";
    
    UIImageView *arrowImage;
    UILabel *nomeServico;
    UILabel *descricaoServico;
    UIView *separatorView;
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        arrowImage = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 18, 33, 32)] autorelease];
        [arrowImage setImage:[UIImage imageNamed:@"img_servico"]];
        arrowImage.tag = 100;
        [cell.contentView addSubview:arrowImage];
        
        nomeServico = [[[UILabel alloc] initWithFrame:CGRectMake(45, 0, 270, 30)] autorelease];
        nomeServico.backgroundColor = [UIColor clearColor];
        nomeServico.textColor = [UIColor blackColor];
        nomeServico.font = [UIFont boldSystemFontOfSize:16];
        nomeServico.minimumFontSize = 10;
        nomeServico.tag = 101;
        [cell.contentView addSubview:nomeServico];
        
        descricaoServico = [[[UILabel alloc] initWithFrame:CGRectMake(45, 30, 270, 40)] autorelease];
        descricaoServico.backgroundColor = [UIColor clearColor];
        descricaoServico.textColor = [UIColor darkGrayColor];
        descricaoServico.numberOfLines = 0;
        descricaoServico.font = [UIFont boldSystemFontOfSize:14];
        descricaoServico.minimumFontSize = 10;
        descricaoServico.tag = 102;
        [cell.contentView addSubview:descricaoServico];
        
        separatorView = [[[UIView alloc] initWithFrame:CGRectMake(10, 69, 300, 1)] autorelease];
        separatorView.backgroundColor = [UIColor grayColor];
        separatorView.tag = 103;
        [cell.contentView addSubview:separatorView];
        
    }else{
        //arrowImage = (UIImageView *)[cell.contentView viewWithTag:100];
        nomeServico = (UILabel *)[cell.contentView viewWithTag:101];
        descricaoServico = (UILabel *)[cell.contentView viewWithTag:102];
        //separatorView = (UIView *)[cell.contentView viewWithTag:103];
    }
    
    [nomeServico setText:[[_servicosArray objectAtIndex:indexPath.row] objectForKey:@"nome"]];
    [descricaoServico setText:[[_servicosArray objectAtIndex:indexPath.row] objectForKey:@"descricao"]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServicoViewController *servicoViewController = [[ServicoViewController alloc] initWithNibName:@"ServicoViewController" bundle:nil];
    [servicoViewController setServicoInformacoes:[_servicosArray objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:servicoViewController animated:YES];
    
    [servicoViewController release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
