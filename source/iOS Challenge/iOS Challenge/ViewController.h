//
//  ViewController.h
//  iOS Challenge
//
//  Created by Miloš Djikić on 1/17/14.
//  Copyright (c) 2014 Pineapple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic)          NSMutableArray   *array;
@property (strong, nonatomic) IBOutlet UITableView      *tableView;


@end
