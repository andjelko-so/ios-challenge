//
//  CustomCell.h
//  iOS Challenge
//
//  Created by Miloš Djikić on 1/18/14.
//  Copyright (c) 2014 Pineapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *commitLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@end
