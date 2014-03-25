//
//  WebViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 25/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = self.race.name;
    NSString *str = [NSString stringWithFormat:@"http://es.pokemon.wikia.com/wiki/%@", self.race.name];
    str = [str stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString: str];
    NSURLRequest *req = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: req];
}

@end
