//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Eddy Chan on 4/13/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

- (float)numberOfWhiskeyShotsForNumberOfBeers:(int)total withAlcoholPercentage:(float)percentage;
- (NSString *)pluralizeShotText:(float)numberOfShots;

@end

@implementation WhiskeyViewController

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    NSLog(@"Slider value changed to %f", sender.value);
    
    int numberOfBeers = sender.value;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = [self numberOfWhiskeyShotsForNumberOfBeers:numberOfBeers
                                                                                  withAlcoholPercentage:alcoholPercentageOfBeer];
    
    NSString *whiskeyText = [self pluralizeShotText:numberOfWhiskeyGlassesForEquivalentAlcoholAmount];
    
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.1f %@)", nil), numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = [self numberOfWhiskeyShotsForNumberOfBeers:numberOfBeers
                                                                                  withAlcoholPercentage:alcoholPercentageOfBeer];
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText = [self pluralizeShotText:numberOfWhiskeyGlassesForEquivalentAlcoholAmount];
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    
    self.resultLabel.text = resultText;
}

- (float)numberOfWhiskeyShotsForNumberOfBeers:(int)total withAlcoholPercentage:(float)percentage {
    // first, calculate how much alcohol is in all those beers...
    int ouncesInOneBeerGlass = 12;  // assume they are 12oz beer bottles
    
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * percentage;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * total;
    
    // now, calculate the equivalent amount of whiskey...
    float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    
    return (ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass);
}

- (NSString *)pluralizeShotText:(float)numberOfShots {
    if (numberOfShots <= 1) {
        return NSLocalizedString(@"shot", @"singular shot");
    }
    
    return NSLocalizedString(@"shots", @"plural of shot");
}

@end
