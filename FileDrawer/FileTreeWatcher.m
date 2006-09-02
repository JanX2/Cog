//
//  FileTreeDelegate.m
//  BindTest
//
//  Created by Zaphod Beeblebrox on 8/20/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "FileTreeWatcher.h"

@implementation FileTreeWatcher

- (id)init
{
	self = [super init];
	if (self)
	{
		kqueue = [[UKKQueue alloc] init];
		[kqueue setDelegate:self];
		
		watchedPaths = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)dealloc
{
	[delegate release];
	[super dealloc];
}


- (void)addPath: (NSString *)path
{
	if ([watchedPaths containsObject:path] == NO) {
		[watchedPaths addObject:path];

		[kqueue addPath: path];
	}
}

-(void) setDelegate: (id)d
{
	delegate = [d retain];
}


-(void) watcher: (id<UKFileWatcher>)kq receivedNotification: (NSString*)nm forPath: (NSString*)fpath
{
	NSLog(@"CHANGED! %@", fpath);
	[delegate refreshPath: fpath];
}

@end
