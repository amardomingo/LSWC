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
              [[Pokemon alloc] initWithName:@"Pepe" race: self.pokedeskModel.races[5]],
              [[Pokemon alloc] initWithName:@"Juan" race: self.pokedeskModel.races[54]]
            ]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.myPokemons removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
