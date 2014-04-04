//
//  WebViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 25/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "WebWikiViewController.h"
#import "WebGoogleViewController.h"

@interface WebWikiViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@end

@implementation WebWikiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = self.race.name;
    [self.titleButton setTitle:self.race.name forState:UIControlStateNormal];
    NSString *str = [NSString stringWithFormat:@"http://es.pokemon.wikia.com/wiki/%@", self.race.name];
    str = [str stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString: str];
    NSURLRequest *req = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: req];
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Google Info"]) {        
        WebGoogleViewController *wvc = segue.destinationViewController;
        wvc.race = self.race;
    }
}

@end
