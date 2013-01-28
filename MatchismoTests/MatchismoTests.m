//
//  MatchismoTests.m
//  MatchismoTests
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "MatchismoTests.h"
#import "Card.h"
#import "PlayingCard.h"
@implementation MatchismoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}



-(void) testCard
{
    Card* card1 = [[Card alloc]init];
    card1.contents = @"cardtest";
    
    Card* card2 = [[Card alloc]init];
    card2.contents = @"cardtest";
    
    
    Card* card3 = [[Card alloc]init];
    card3.contents = @"notcardtest";
    
    NSArray* matchingArray = [[NSArray alloc]initWithObjects:card3,card2,nil ];
    STAssertEquals([card1 match:matchingArray], 1, @"it should match");
    
    NSArray* unmatchingArray = [[NSArray alloc]initWithObjects:card3,nil ];
    STAssertEquals([card1 match:unmatchingArray], 0, @"it should not match");
    NSLog(@"Great success");
}

-(void) testPlayingCard
{
    NSUInteger max = 13;
    STAssertEquals([PlayingCard maxRank] ,max,@"should be 13");
    // cant set invalid suit
    PlayingCard* pc = [[PlayingCard alloc]init];
    pc.suit = @"x";
    STAssertEquals(pc.suit, @"?", @"should not be set");
    
    pc.suit = @"♦";
    STAssertEquals(pc.suit, @"♦", @"should  be set");
    
    // cant set rank more than 13
    pc.rank = 14;
    STAssertEquals(pc.rank, (NSUInteger)0, @"Cnat be");
    pc.rank = 1;
    STAssertEquals(pc.rank, (NSUInteger)1, @"Cnat be");
    STAssertEqualObjects(pc.contents, @"A♦", @"Ace");
    pc.contents = @"gabbar";
    STAssertEqualObjects(pc.contents, @"A♦", @"Ace");
}
@end
