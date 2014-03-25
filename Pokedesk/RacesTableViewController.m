//
//  RacesTableViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 25/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "RacesTableViewController.h"
#import "PokedeskModel.h"
#import "WebViewController.h"
#import "Type.h"
#import "Race.h"


@interface RacesTableViewController ()
@property (strong, nonatomic) PokedeskModel *pokedeskModel;
@end

@implementation RacesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

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
    return [self.type.races count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Race Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    Race * race = self.type.races[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:race.icon];
    cell.textLabel.text = race.name;
    cell.detailTextLabel.text = [race.code description];
    return cell;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection: (NSInteger)section
{
    return self.type.name;
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Web Info"]) {
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        WebViewController *wvc = segue.destinationViewController;        
        wvc.race = self.type.races[ip.row];
    }
}

@end
