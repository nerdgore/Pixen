//
//  PXHotkeysPreferencesController.m
//  Pixen
//
//  Copyright 2011-2012 Pixen Project. All rights reserved.
//

#import "PXHotkeysPreferencesController.h"

#import "PXHotkeyFormatter.h"

@implementation PXHotkeysPreferencesController

@synthesize form = _form;

- (id)init
{
	self = [super initWithNibName:@"PXHotkeysPreferences" bundle:nil];
	return self;
}

- (void)awakeFromNib
{
	for (NSCell *currentCell in [self.form cells])
	{
		[currentCell setFormatter:[[PXHotkeyFormatter alloc] init]];
	}
}

@end
