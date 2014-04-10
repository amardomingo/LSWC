//
//  WebGoogleViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 04/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "WebGoogleViewController.h"

@interface WebGoogleViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebGoogleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.race.name;
    NSString *str = [NSString stringWithFormat:@"https://www.google.es/search?q=%@", self.race.name];
    str = [str stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString: str];
    NSURLRequest *req = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: req];
}


@end
