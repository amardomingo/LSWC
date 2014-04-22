//
//  EditPokemonViewController.m
//  Pokedesk
//
//  Created by g111 DIT UPM on 10/04/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "EditPokemonViewController.h"
#import "PokedeskModel.h"
#import "Race.h"

@interface EditPokemonViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet PokedeskModel *pokedeskModel;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@end

@implementation EditPokemonViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.nombre != nil && self.race != nil && self.row != -1){
        NSInteger row = [self searchPokemon:self.race];
        [self.picker selectRow:row inComponent:0 animated:YES];
        self.nameTextField.text = self.nombre;
    } else {
        NSInteger row = 0;
        [self.picker selectRow:row inComponent:0 animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

	// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pokedeskModel.races count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 300.0f, 60.0f)]; //x and width are mutually correlated
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = ((Race *)[self.pokedeskModel.races objectAtIndex:row]).name;
    [self updatePokemon:row];
    return label;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self updatePokemon:row];
}

-(void) updatePokemon:(NSInteger) row{
    self.race = [self.pokedeskModel.races objectAtIndex:row];
    self.photo.image = [UIImage imageNamed:self.race.icon];
    [self.photo setNeedsDisplay];
}

-(NSInteger) searchPokemon:(Race *) race{
    NSInteger i = 0;
    BOOL encontrado = NO;
    while(!encontrado && i < [self.pokedeskModel.races count]){
        if([race.name isEqualToString:((Race *)[self.pokedeskModel.races objectAtIndex:i]).name]){
            encontrado = YES;
        }
        else
            i++;
    }
    if (encontrado) return i;
    return -1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Save Pokemon"]) {
        self.nombre = self.nameTextField.text;
    }
}


@end
