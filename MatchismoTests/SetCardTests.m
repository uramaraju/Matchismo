//
//  SetCardTests.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 2/10/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "SetCardTests.h"
#import "SetCard.h"
@implementation SetCardTests

-(void) testMatchSetCardsOnlyShadeMatches
{
    SetCard* card1 = [[SetCard alloc]initWithRank:3 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    SetCard* card2 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][1] color:@"Green" shade:@"Solid"];
    SetCard* card3 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    
    NSArray* otherCards = @[card2,card3];
    
    int score = [card1 match:otherCards];
    
    STAssertEquals(score, 3-1, @"They should be equal");
}


-(void) testMatchSetCardsNoneMatches
{
    SetCard* card1 = [[SetCard alloc]initWithRank:3 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    SetCard* card2 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][1] color:@"Green" shade:@"Open"];
    SetCard* card3 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    
    NSArray* otherCards = @[card2,card3];
    
    int score = [card1 match:otherCards];
    
    STAssertEquals(score, 0, @"They should be equal");
}
-(void) testMatchSetCardsTwoMatch
{
    SetCard* card1 = [[SetCard alloc]initWithRank:3 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    SetCard* card2 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][1] color:@"Red" shade:@"Solid"];
    SetCard* card3 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    
    NSArray* otherCards = @[card2,card3];
    
    int score = [card1 match:otherCards];
    
    STAssertEquals(score, 9-1, @"They should be equal");
}

-(void) testMatchSetCardsTwoMatchViaDifferent
{
    SetCard* card1 = [[SetCard alloc]initWithRank:3 symbol:[SetCard validSymbols][0] color:@"Red" shade:@"Solid"];
    SetCard* card2 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][1] color:@"Blue" shade:@"Shade"];
    SetCard* card3 = [[SetCard alloc]initWithRank:2 symbol:[SetCard validSymbols][0] color:@"Green" shade:@"Open"];
    
    NSArray* otherCards = @[card2,card3];
    int score = [card1 match:otherCards];
    STAssertEquals(score, 9-1, @"They should be equal");
}
@end
