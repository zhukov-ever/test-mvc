//
//  AwesomeVC.m
//  testMVC
//
//  Created by Nikita on 15/08/14.
//  Copyright (c) 2014 vigroup. All rights reserved.
//

#import "AwesomeViewController.h"
#import "AwesomeManager.h"

#define kCellIdentifier @"kCellIdentifier"

@interface AwesomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIAlertView* alertView;

@end

@implementation AwesomeViewController
@synthesize alertView = m_alertView;

#pragma mark override

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataWillLoad:) name:kAwesomeManagerWillLoad object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataDidLoad:) name:kAwesomeManagerDidLoad object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem* _barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self
                                                                                action:@selector(rightButtonHandler:)];
    self.navigationItem.rightBarButtonItem = _barButton;
}

                                                                   
                                                                   
#pragma mark handlers

- (void) rightButtonHandler:(id)sender
{
    [[AwesomeManager shared] reload];
}

- (void) dataWillLoad:(NSNotification*)sender
{
    [self.alertView show];
}

- (void) dataDidLoad:(NSNotification*)sender
{
    [self.alertView dismissWithClickedButtonIndex:-1 animated:YES];
    [self.tableView reloadData];
}


#pragma mark private

-(UIAlertView*) alertView
{
    if (!m_alertView)
    {
        m_alertView = [[UIAlertView alloc] initWithTitle:@"loading ..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    }
    return m_alertView;
}


#pragma mark UITableViewDataSource, UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AwesomeManager shared].data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* _cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!_cell)
    {
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    
    if (indexPath.row < [[AwesomeManager shared].data count])
    {
        AwesomeInfo* _info = [AwesomeManager shared].data[indexPath.row];
        _cell.textLabel.text = _info.name;
        _cell.detailTextLabel.text = _info.sub;
    }
    
    return _cell;
}



@end
