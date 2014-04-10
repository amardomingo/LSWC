//
//  Pokemon.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 10/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon
- (instancetype) initWithName:(NSString*)name
                         race:(Race*)race;

{
    if (self = [super init]) {
        _name = name;
        _race = race;
    }
    return self;
}
@end
