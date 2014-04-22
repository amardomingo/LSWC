//
//  EditPokemonViewController.h
//  Pokedesk
//
//  Created by g111 DIT UPM on 10/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Race.h"

@interface EditPokemonViewController : UIViewController
@property (strong, nonatomic) Race * race;
@property (strong, nonatomic) NSString * nombre;
@property NSInteger row;
@end
