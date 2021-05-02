//
//  TimeField.h
//  Cog
//
//  Created by Vincent Spader on 2/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TimeField : NSTextField

@property (nonatomic) NSTimeInterval currentTime;
@property (nonatomic) NSTimeInterval duration;

@end
