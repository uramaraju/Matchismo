//
//  SetCard.h
//  Matchismo
//
//  Created by Umasankar Ramaraju on 2/10/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
-(id) initWithRank:(int)rank symbol:(NSString*)symbol color:(NSString*)color shade:(NSString*)shade;
@property (nonatomic, readonly) int rank;
@property (nonatomic, readonly) NSString* symbol;
@property (nonatomic, readonly) NSString* color;
@property (nonatomic, readonly) NSString* shade;

+(int) maxRank;
+(int) minRank;
+(NSArray*) validSymbols;
+(NSArray*) validColors;
+(NSArray*) validShades;
@end
