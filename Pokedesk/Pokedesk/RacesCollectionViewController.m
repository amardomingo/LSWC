//
//  RacesCollectionViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 04/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "RacesCollectionViewController.h"
#import "PokemonCollectionViewCell.h"
#import "PokedeskModel.h"
#import "WebWikiViewController.h"
#import "Type.h"
#import "Race.h"

@interface RacesCollectionViewController ()
@end

@implementation RacesCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.type.races count];
}

- (PokemonCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                       cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PokemonCell";
    PokemonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    Race * race = self.type.races[indexPath.item];
    
    cell.pokemonImage.image = [UIImage imageNamed:race.icon];
    cell.pokemonLabel.text = race.name;
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Wiki Info"]) {
        NSIndexPath *ip = [self.collectionView indexPathForCell:sender];
        WebWikiViewController *wvc = segue.destinationViewController;
        wvc.race = self.type.races[ip.item];
    }
}


@end
