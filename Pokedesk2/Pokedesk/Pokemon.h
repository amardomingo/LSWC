//
//  Pokemon.h
//  Pokedesk
//
//  Created by g111 DIT UPM on 10/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Race.h"

@interface Pokemon : NSObject
@property (nonatomic,strong) Race * race;
@property (nonatomic,strong) NSString* name;
- (instancetype) initWithName:(NSString*)name
                         race:(Race*)race;
@end
