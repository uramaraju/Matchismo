//
//  PlayingCard.h
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong,nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+(NSUInteger) maxRank;
+(NSArray* ) validSuits;
@end
