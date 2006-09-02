//
//  DirectoryNode.m
//  Cog
//
//  Created by Vincent Spader on 8/20/2006.
//  Copyright 2006 Vincent Spader. All rights reserved.
//

#import "DirectoryNode.h"
#import "FileNode.h"

@implementation DirectoryNode

-(id)initWithPath:(NSString *)p controller:(id) c
{
	self = [super initWithPath:p];
	if (self)
	{
		controller = [c retain];
	}
	
	return self;
}

- (void)dealloc {
	[controller release];
	[super dealloc];
}

- (BOOL)isLeaf
{
	return NO;
}

- (NSArray *)subpaths
{
	if (subpaths == nil)
	{
		subpaths = [[NSMutableArray alloc] init];
		NSArray *contents = [[NSFileManager defaultManager] directoryContentsAtPath:path];
		NSEnumerator *e = [contents objectEnumerator];
		NSString *s;
		while ((s = [e nextObject]))
		{
			if ([s characterAtIndex:0] == '.')
			{
				continue;
			}

			BOOL isDir;
			PathNode *newNode;
			NSString *newSubpath = [path stringByAppendingPathComponent: s];
			
			[[NSFileManager defaultManager] fileExistsAtPath:newSubpath isDirectory:&isDir];
			
			if (!isDir && ![[controller acceptableFileTypes] containsObject:[s pathExtension]])
			{
				continue;
			}
			
			if (isDir)
				newNode = [[DirectoryNode alloc] initWithPath: newSubpath controller:controller];
			else
				newNode = [[FileNode alloc] initWithPath: newSubpath];
			
			[subpaths addObject:newNode];

			[newNode release];
		}
		[[controller watcher] addPath:[self path]];
	}
	
//	NSLog(@"subpaths; %@", subpaths);
	return subpaths;
}

- (void)setSubpaths:(id)s
{
	[s retain];
	[subpaths release];
	subpaths = s;
}

- (unsigned int)countOfSubpaths
{
	return [[self subpaths] count];
}

- (PathNode *)objectInSubpathsAtIndex:(unsigned int)index
{
	return [[self subpaths] objectAtIndex:index];
}

@end
