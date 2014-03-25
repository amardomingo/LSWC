//
//  RacesTableViewController.h
//  Pokedesk
//
//  Created by g111 DIT UPM on 25/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Type.h"

@interface RacesTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (strong, nonatomic) Type *type;
@end
