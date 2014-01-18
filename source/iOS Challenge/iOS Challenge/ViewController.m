//
//  ViewController.m
//  iOS Challenge
//
//  Created by Miloš Djikić on 1/17/14.
//  Copyright (c) 2014 Pineapple. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "CommitObject.h"


#define kTableViewRowHeight 70


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.array = tempArray;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self fetchCommitsHTTP];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return [self.array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger row = [indexPath row];
    
    static NSString *DayCellIdentifier = @"CustomCell";
    
    
	CustomCell *cell = (CustomCell *)[tableView_ dequeueReusableCellWithIdentifier:DayCellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell"
													 owner:self
												   options:nil];
		
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[CustomCell class]])
				cell = (CustomCell *)oneObject;
    }
	
    cell.nameLabel.text = [((CommitObject*)[self.array objectAtIndex:row]) name];
    cell.commitLabel.text = [((CommitObject*)[self.array objectAtIndex:row]) commit];
    cell.messageLabel.text = [((CommitObject*)[self.array objectAtIndex:row]) message];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewRowHeight;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - Get Commits

- (void)fetchCommitsHTTP {
    
    NSString *stringURL = @"https://api.github.com/repos/rails/rails/commits";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:stringURL]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(fetchCommitsHTTPComplete:)];
	[request setDidFailSelector:@selector(fetchCommitsHTTPFailed:)];
	[request startAsynchronous];
}

- (void)fetchCommitsHTTPFailed:(ASIHTTPRequest *)theRequest {
	NSLog(@"Error:%@",[[theRequest error] localizedDescription]);
}

- (void)fetchCommitsHTTPComplete:(ASIHTTPRequest *)theRequest
{
    
    [self.array removeAllObjects];
    
    NSLog(@"Message:%@",[theRequest responseString]);
    
    NSError *jsonError = nil;
    NSArray *arrayTemp = [NSJSONSerialization JSONObjectWithData:[theRequest responseData] options:0 error:&jsonError];
    
    for (int i = 0; i < [arrayTemp count]; i++) {
        NSDictionary *dict2 = [arrayTemp objectAtIndex:i];
        
        NSDictionary *dict = [dict2 objectForKey:@"commit"];
        
        CommitObject *commit = [[CommitObject alloc] init];
        commit.message = [dict objectForKey:@"message"];
        
        NSDictionary *commiter = [dict objectForKey:@"committer"];
        commit.name = [commiter objectForKey:@"name"];
        commit.commit = [commiter objectForKey:@"date"];
        
        [self.array addObject:commit];
    }
    
    [self.tableView reloadData];
    
    
}


@end
