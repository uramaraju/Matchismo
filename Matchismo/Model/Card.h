//
//  Card.h
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString* contents;
@property (readonly)NSAttributedString* attributedContents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

-(int)match:(NSArray*)others;

@end
