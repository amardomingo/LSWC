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

@interface RacesTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>
@property (strong, nonatomic) NSArray * filteredRacesArray;
@end

@implementation RacesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filteredRacesArray = [NSArray array];
    
    // Registramos como se crean las celdas de la
    // tabla de resultados.
    [self.searchDisplayController.searchResultsTableView registerClass: [UITableViewCell class]
                                                forCellReuseIdentifier: @"PokemonCell"];
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredRacesArray count];
    }else {
        return [self.type.races count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PokemonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Race * race;
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        race = self.filteredRacesArray[indexPath.row];
    } else {
        race = self.type.races[indexPath.row];
    }
    
    cell.imageView.image = [UIImage imageNamed:race.icon];
    cell.textLabel.text = race.name;
    
    return cell;
}

- (void) updateFilteredRacesWithName: (NSString * ) text {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@" , text];
    self.filteredRacesArray = [self.type.races filteredArrayUsingPredicate:pred];
}

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self updateFilteredRacesWithName:searchString];
    return YES;
}

//segue programaticamente
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"Show Wiki Info"sender:tableView];
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Wiki Info"]) {
        WebWikiViewController *wvc = segue.destinationViewController;
        if(sender == self.searchDisplayController.searchResultsTableView){
            NSIndexPath *ip = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            wvc.race = self.filteredRacesArray[ip.row];
        } else {
            NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
            wvc.race = self.type.races[ip.row];
        }        
    }
}

@end
