//
//  TypesTableViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 25/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "TypesTableViewController.h"
#import "RacesCollectionViewController.h"
#import "PokedeskModel.h"
#import "Type.h"
#import "Race.h"

@interface TypesTableViewController ()
@property (strong, nonatomic) IBOutlet PokedeskModel *pokedeskModel;

@end

@implementation TypesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pokedeskModel.types count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Type Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [self.pokedeskModel.types[indexPath.row] name];
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Type"]) {
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        RacesCollectionViewController *rcvc = segue.destinationViewController;
        rcvc.type = self.pokedeskModel.types[ip.row];
        rcvc.navTitle.title = [self.pokedeskModel.types[ip.row] name];
    }
}

@end
