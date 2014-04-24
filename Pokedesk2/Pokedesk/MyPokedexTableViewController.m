//
//  MyPokedexTableViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 10/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "MyPokedexTableViewController.h"
#import "Pokemon.h"
#import "PokedeskModel.h"
#import "EditPokemonViewController.h"


@interface MyPokedexTableViewController ()
@property (strong, nonatomic) NSMutableArray * myPokemons;
@property (strong, nonatomic) IBOutlet PokedeskModel *pokedeskModel;
@end

@implementation MyPokedexTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPokemons = [NSMutableArray array]; //Array para guardar pokemons
    
    //Para pruebas, contenido inicial:
    [self.myPokemons addObjectsFromArray:
            @[
              [[Pokemon alloc] initWithName:@"Pepe" race: self.pokedeskModel.races[150]],
              [[Pokemon alloc] initWithName:@"Juan" race: self.pokedeskModel.races[54]]
            ]];
    
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myPokemons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyPokemonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Pokemon* pokemon = self.myPokemons[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    cell.detailTextLabel.text = pokemon.race.name;
    cell.imageView.image = [UIImage imageNamed:pokemon.race.icon];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.myPokemons removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

//Lanzar segue programatico
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEditing] == YES) {
        //Lanzar segue programatico
        [self performSegueWithIdentifier:@"Edit Pokemon"sender:tableView];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditPokemonViewController *epvc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"Edit Pokemon"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        
        epvc.race = ((Pokemon *)self.myPokemons[ip.row]).race;
        epvc.nombre =((Pokemon *)self.myPokemons[ip.row]).name;
        epvc.row = ip.row;
    } else if ([segue.identifier isEqualToString:@"Create Pokemon"]) {
        epvc.row = -1;
    }
}

-(IBAction)addPokemon:(UIStoryboardSegue *)unwindSegue{
    EditPokemonViewController *epvc = unwindSegue.sourceViewController;
    if (epvc.row == -1) {
        [self.myPokemons addObject:[[Pokemon alloc] initWithName:epvc.nombre race: epvc.race]];
    } else {
        self.myPokemons[epvc.row] =[[Pokemon alloc] initWithName:epvc.nombre race: epvc.race];
    }
    [self.tableView reloadData];
}

@end
