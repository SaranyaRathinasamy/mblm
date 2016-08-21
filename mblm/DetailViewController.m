//
//  DetailViewController.m
//  mblm
//
//  Created by Saranya Rathinasamy on 21/08/16.
//  Copyright (c) 2016 Saranya Rathinasamy. All rights reserved.
//

#import "DetailViewController.h"

enum userEnumOptions
{
    Home = 0,
    Active_Releases,
    Build_Catalog,
    Enrollment,
    Contact_us
    
};
@interface DetailViewController ()

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
@end
