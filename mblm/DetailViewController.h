//
//  DetailViewController.h
//  mblm
//
//  Created by Saranya Rathinasamy on 21/08/16.
//  Copyright (c) 2016 Saranya Rathinasamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
