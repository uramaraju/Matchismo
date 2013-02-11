//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 2/10/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumberModeControl;
@end

@implementation PlayingCardGameViewController
@synthesize game = _game;
-(CardMatchingGame*) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc]init]];
        [self setMatchMode:self.matchNumberModeControl];
    }
    return _game;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setMatchMode:(UISegmentedControl *)sender
{
    NSString* titleOfMode = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    int mode = [titleOfMode intValue] == 0 ? 2 : [titleOfMode intValue];
    NSLog(@"matching mode %d", mode);
    self.game.matchingCardCount= mode;
}
@end
