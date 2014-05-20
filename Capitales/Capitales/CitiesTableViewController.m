//
//  CitiesTableViewController.m
//  Capitales
//
//  Created by g111 DIT UPM on 20/05/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "CityCell.h"

#define OPE_W_URL @"http://api.openweathermap.org/data/2.5/weather"

@interface CitiesTableViewController ()
@property (strong) NSMutableArray * cities;
@end

@implementation CitiesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadCities];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"City Cell";
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.cityLabel.text = self.cities[indexPath.row];
    
    // Construimos la URL añadiendo la query
    NSString * s = [NSString stringWithFormat:@"%@?q=%@&units=metric&lang=sp",OPE_W_URL,self.cities[indexPath.row]];
    
    s = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:s];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (! data) {
        NSLog(@"Error: no se han descargado datos.");
        return nil;
    }
    
    NSDictionary * dic;
    NSError * err;
    dic = [NSJSONSerialization JSONObjectWithData:data
                                          options:NSJSONReadingMutableContainers
                                            error:&err];
    if (!dic) {
        NSLog(@"Error parsing JSON = %@",[err localizedDescription]);
        return nil;
    }
    
    
    // Log main keys
    for (NSString *key in [dic allKeys]) {
        NSLog(@"KEY = %@ -> %@",key, dic[key]);
    }
    
    NSNumber * ntemp = dic[@"main"][@"temp"];
    cell.tempLabel.text = [NSString stringWithFormat:@"%d ºC",ntemp.intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSNumber * ndate = dic[@"sys"][@"sunrise"];
    NSDate * date = [[NSDate alloc] initWithTimeIntervalSince1970:ndate.doubleValue];
    
    cell.sunriseLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
    ndate = dic[@"sys"][@"sunset"];
    date = [[NSDate alloc] initWithTimeIntervalSince1970:ndate.doubleValue];
    
    cell.sunsetLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
    cell.weatherLabel.text = dic[@"weather"][0][@"description"];
    
    NSNumber * nlatitude = dic[@"coord"][@"lat"];
    NSNumber * nlongitude =  dic[@"coord"][@"lon"];
    
    MKCoordinateRegion reg;
    reg.center.latitude = nlatitude.floatValue;
    reg.center.longitude = nlongitude.floatValue;
    reg.span.latitudeDelta = 0.5;
    reg.span.longitudeDelta = 0.5;
	[cell.map setRegion:reg animated:NO];
    cell.map.mapType = MKMapTypeHybrid;
    cell.map.userInteractionEnabled = NO;
    
    return cell;
}

- (void) loadCities {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    self.cities = [NSMutableArray arrayWithContentsOfFile:path];
    if ( ! self.cities) {
        self.cities = [NSMutableArray  arrayWithArray:@[@"Madrid",
                                                        @"Paris",
                                                        @"Lisboa",
                                                        @"Londres",
                                                        @"Moscu",
                                                        @"Caracas",
                                                        @"Tripoli",
                                                        @"Tokio"]];
    }
}
@end
