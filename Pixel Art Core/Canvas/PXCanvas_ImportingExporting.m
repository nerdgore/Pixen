//
//  PXCanvas_ImportingExporting.m
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "PXCanvas_ImportingExporting.h"

#import "PXCanvas_Layers.h"
#import "PXCanvas_Modifying.h"
#import "PXLayer.h"

@implementation PXCanvas(ImportingExporting)

+ (id)canvasWithContentsOfFile:(NSString *)aFile
{
	return [[[self alloc] initWithContentsOfFile:aFile] autorelease];
}

- (id)initWithContentsOfFile:(NSString *)aFile
{
	if([[aFile pathExtension] isEqualToString:PXISuffix])
	{
		[self release];
		return self = [[NSKeyedUnarchiver unarchiveObjectWithFile:aFile] retain];
	}
	else
	{
		return [self initWithImage:[[[NSImage alloc] initWithContentsOfFile:aFile] autorelease]];
	}
	[self release];
	return self = nil;
}

- (NSBitmapImageRep *)exportImageRep {
	NSRect frame = NSMakeRect(0.0f, 0.0f, [self size].width, [self size].height);
	
	NSImage *outputImage = [self exportImage];
	[outputImage lockFocus];
	
	NSBitmapImageRep *rep = [[[NSBitmapImageRep alloc] initWithFocusedViewRect:frame] autorelease];
	
	[outputImage unlockFocus];
	
	// And now, we interrupt our regularly scheduled codegram for a hack: remove color profile info from the rep because we don't handle it on loading.
	[rep setProperty:NSImageColorSyncProfileData withValue:nil];
	
	return rep;
}

- (NSData *)imageDataWithType:(NSBitmapImageFileType)storageType
				   properties:(NSDictionary *)properties
{
	NSBitmapImageRep *rep;
	NSRect frame = NSMakeRect(0, 0, [self size].width, [self size].height);
	// We use a white background color for jpegs because of a bug in 10.3
	NSImage *outputImage = ((storageType == NSJPEGFileType) ? [self exportImageWithBackgroundColor:[NSColor whiteColor]] : [self displayImage]);
	
	[outputImage lockFocus];
	rep = [[[NSBitmapImageRep alloc] initWithFocusedViewRect:frame] autorelease];
	[outputImage unlockFocus];
	
	// And now, we interrupt our regularly scheduled codegram for a hack: remove color profile info from the rep because we don't handle it on loading.
	[rep setProperty:NSImageColorSyncProfileData withValue:nil];
	
	return [rep representationUsingType:storageType properties:properties];
}	

- (void)replaceActiveLayerWithImage:(NSImage *)anImage
{
	NSImageRep *firstRep = [[anImage representations] objectAtIndex:0];
	NSSize newSize = NSMakeSize((int)[firstRep pixelsWide], (int)[firstRep pixelsHigh]);
	
	for (PXLayer *currentLayer in layers) {
		[currentLayer setSize:newSize withOrigin:NSZeroPoint backgroundColor:PXGetClearColor()];
	}
	
	free(selectionMask);
	selectionMask = calloc(newSize.width * newSize.height, sizeof(BOOL));
	selectedRect = NSZeroRect;
	if([layers count] == 0)
	{
		[layers addObject:[[[PXLayer alloc] initWithName:@"Main Layer" size:newSize] autorelease]];
		[[layers lastObject] setCanvas:self];
		[self activateLayer:[layers lastObject]];
	}
	[self applyImage:anImage toLayer:activeLayer];
	[self updatePreviewSize];
	[self layersChanged];
}

- (id)initWithImage:(NSImage *)anImage
{
	self = [self init];
	[self replaceActiveLayerWithImage:anImage];
	return self;
}

- (NSImage *)displayImage
{
	NSImage *imageCopy = [[NSImage alloc] initWithSize:[self size]];
	[imageCopy lockFocus];
	
	[[NSColor clearColor] set];
	NSRectFill(NSMakeRect(0, 0, [self size].width, [self size].height));
	
	for (PXLayer *layer in layers)
	{
		if ([layer visible] && [layer opacity] > 0)
		{
			[[layer displayImage] compositeToPoint:canvasRect.origin
										  fromRect:canvasRect
										 operation:NSCompositeSourceOver
										  fraction:[layer opacity] / 100.0f];
		}
	}
	
	[imageCopy unlockFocus];
	return [imageCopy autorelease];	
}

- (NSImage *)exportImageWithBackgroundColor:(NSColor *)color
{
	NSImage *imageCopy = [[NSImage alloc] initWithSize:[self size]];
	[imageCopy lockFocus];
	// We fill the color (if necessary) after because of the backwards order in which we're doing this
	if (color)
	{
		[color set];
		NSRectFillUsingOperation(canvasRect, NSCompositeSourceOver);
	}
	
	for (PXLayer *layer in layers)
	{
		if ([layer visible] && [layer opacity] > 0)
		{
			[[layer exportImage] compositeToPoint:canvasRect.origin
										 fromRect:canvasRect
										operation:NSCompositeSourceOver
										 fraction:[layer opacity] / 100.0f];
		}
	}
	
	[imageCopy unlockFocus];
	//this probably won't do any good... but there aren't any reps before the above execute.  Replace with ImageIO!
	// [[[imageCopy representations] objectAtIndex:0] setColorSpaceName:NSDeviceRGBColorSpace];
	return [imageCopy autorelease];	
}

- (NSImage *)exportImage
{
	return [self exportImageWithBackgroundColor:nil];
}

@end
