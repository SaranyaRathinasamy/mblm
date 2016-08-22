//
//  activeReleaseExpandedTableViewCell.h
//  mblm
//
//  Created by Saranya Rathinasamy on 22/08/16.
//  Copyright (c) 2016 Saranya Rathinasamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface activeReleaseExpandedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *buildName;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewVar;
@property (strong, nonatomic) IBOutlet UITableView *expandedTableView;
@property (strong, nonatomic) IBOutlet UILabel *moreBuildsLabel;

@end
