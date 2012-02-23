//
//  PXMonotoneBackground.h
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "PXBackground.h"

@interface PXMonotoneBackground : PXBackground
{
  @private
	NSColorWell *__unsafe_unretained _colorWell;
	NSColor *_color;
}

@property (nonatomic, unsafe_unretained) IBOutlet NSColorWell *colorWell;

@property (nonatomic, strong) NSColor *color;

- (IBAction)configuratorColorChanged:(id)sender;

@end
