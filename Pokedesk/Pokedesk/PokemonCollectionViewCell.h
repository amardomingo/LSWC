//
//  PokemonCollectionViewCell.h
//  Pokedesk
//
//  Created by g111 DIT UPM on 04/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokemonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *pokemonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;

@end
