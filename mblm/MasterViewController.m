//
//  MasterViewController.m
//  mblm
//
//  Created by Saranya Rathinasamy on 21/08/16.
//  Copyright (c) 2016 Saranya Rathinasamy. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


@interface MasterViewController ()
@property (nonatomic,strong)NSString *userTypes;
@property (nonatomic,strong)NSMutableArray *userOptions;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _userTypes = @"user";
    self.splitViewController.preferredPrimaryColumnWidthFraction = 0.5;
    self.splitViewController.delegate = self;
    [self loadUserOptions];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}
-(void)loadUserOptions
{
    if([_userTypes isEqualToString:@"user"])
        _userOptions = [[NSMutableArray alloc]initWithObjects:@"Home",@"Active Releases",@"Build Catalog",@"Enrollment",@"Contact Us", nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setOptionsString:(int)indexPath.row];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]
        && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]]
        && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return NO;
        
    } else {
        
        return YES;
        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_userOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [_userOptions objectAtIndex:indexPath.row];
}

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    if([vc isKindOfClass:[MasterViewController class]])
        return YES;
    else
        return NO;
}


@end
