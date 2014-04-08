//
//  RacesTableViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 08/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "RacesTableViewController.h"
#import "WebWikiViewController.h"
#import "Type.h"
#import "Race.h"

@interface RacesTableViewController ()

@end

@implementation RacesTableViewController

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
    static NSString *CellIdentifier = @"PokemonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Race * race = self.type.races[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:race.icon];
    cell.textLabel.text = race.name;
    
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Wiki Info"]) {
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        WebWikiViewController *wvc = segue.destinationViewController;
        wvc.race = self.type.races[ip.item];
    }
}

@end
