//
//  DetailViewController.m
//  mblm
//
//  Created by Saranya Rathinasamy on 21/08/16.
//  Copyright (c) 2016 Saranya Rathinasamy. All rights reserved.
//

#import "DetailViewController.h"
#import "activeReleaseExpandedTableViewCell.h"
enum userEnumOptions
{
    Home = 0,
    Active_Releases,
    Build_Catalog,
    Enrollment,
    Contact_us
    
};
@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIView *detailsContentView;

//Variables for Active Releases
@property (strong, nonatomic) IBOutlet UITableView *activeReleasesTableView;
@property (strong, nonatomic) NSArray *activeReleasesArray;
@property (strong, nonatomic) UIView *viewExpandedView;
@property (nonatomic) BOOL isViewVisible;
@property (retain) NSIndexPath* selectedIndexPath;

@end

@implementation DetailViewController


#pragma mark - Managing the detail item



- (void)configureView {
    // Update the user interface for the detail item.
    switch (_optionsString) {
        case Home:
            [self configureHomeView];break;

            break;
            
        case Enrollment:
            [self configureEnrollmentView];break;
            
        case Active_Releases:
            [self configureActiveReleases];break;
            
        default:
             [self configureHomeView];
            break;
    }


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureEnrollmentView
{
    [[NSBundle mainBundle] loadNibNamed:@"Enrollment" owner:self options:nil];
    self.view = _enrollmentViewNib;

}
-(void)configureHomeView
{
    [[NSBundle mainBundle] loadNibNamed:@"Home" owner:self options:nil];
    self.view = _homeViewNib;

}
-(void)configureActiveReleases
{
    [[NSBundle mainBundle] loadNibNamed:@"ActiveReleases" owner:self options:nil];
    [self.detailsContentView addSubview: _activeReleasesNib];
    
    _activeReleasesTableView.delegate = self;
    _activeReleasesTableView.dataSource = self;
    
    _activeReleasesArray = [NSArray arrayWithObjects:@"7.4.0",@"7.2.0",@"7.2.8", nil];
    
}

#pragma mark - TableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 10)
        return _activeReleasesArray.count;
    else if(tableView.tag == 11)
        return 2;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 10)
    {
        
        
        static NSString *CellIdentifier1 = @"Cell1";
        static NSString *CellIdentifier2 = @"Cell2";
        
        
        
        NSIndexPath* indexPathSelected = self.selectedIndexPath;
        
        if ( nil == indexPathSelected || [indexPathSelected compare: indexPath] != NSOrderedSame )
        {
            activeReleaseExpandedTableViewCell *expCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (expCell == nil) {
                // Load the top-level objects from the custom cell XIB.
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"activeReleaseExpandedViewCell" owner:self options:nil];
                // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                expCell = [topLevelObjects objectAtIndex:0];
                expCell.buildName.text = [_activeReleasesArray objectAtIndex:indexPath.row];
                return expCell;
            }
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if(cell == nil)
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
            cell.textLabel.text = [_activeReleasesArray objectAtIndex:indexPath.row];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            return cell;

        }
        
        return nil;
    
    }
    else if (tableView.tag == 11)
    {
        static NSString *cellIdentifier = @"activeReleasesCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.text = @"sample";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 10)
    {
        NSArray* toReload = [NSArray arrayWithObjects: indexPath, self.selectedIndexPath, nil];
        self.selectedIndexPath = indexPath;
        
        [tableView reloadRowsAtIndexPaths: toReload withRowAnimation: UITableViewRowAnimationMiddle];
    
    }

    /*
        if(!_isViewVisible)
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

            activeReleaseExpandedTableViewCell *expCell = [tableView dequeueReusableCellWithIdentifier:@"expandableCell"];
            if (expCell == nil) {
                // Load the top-level objects from the custom cell XIB.
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"activeReleaseExpandedViewCell" owner:self options:nil];
                // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                expCell = [topLevelObjects objectAtIndex:0];
                expCell.buildName.text = cell.textLabel.text;
            }
            [cell addSubview:expCell];
             [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height + 160 + 5)];
            [tableView beginUpdates];
            [tableView endUpdates];
     */
            /*
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

            CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
            _viewExpandedView = [[UIView alloc]initWithFrame:CGRectMake(cellRect.origin.x, cellRect.origin.y    + 50, cellRect.size.width, 150)];
            UITableView *activeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,   _viewExpandedView.frame.size.width, 100)];
            [activeTableView setDelegate:self];
            [activeTableView setDataSource:self];
            [activeTableView setTag:11];
            [activeTableView setScrollEnabled:NO];
            [_viewExpandedView addSubview:activeTableView];
    
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10,tableView.frame.origin.y + tableView.frame.size.height + 5 , 70, 25)];
            label.text = @"more Builds";
            [label setBackgroundColor:[UIColor greenColor]];
            [_viewExpandedView addSubview:label];
            
            [cell addSubview:_viewExpandedView];
    
            [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height + _viewExpandedView.frame.size.height + 5)];
            */
      /*      _isViewVisible = YES;
        }
        else
        {
            
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [tableView reloadInputViews];
            
            _isViewVisible = NO;
        }
        
    }*/
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //check if the index actually exists
//    if(tableView.tag==10) {
        if ( self.selectedIndexPath != nil && [self.selectedIndexPath compare: indexPath] == NSOrderedSame )
        {
            return tableView.rowHeight * 2;
        }
        
        return tableView.rowHeight;
}

@end
