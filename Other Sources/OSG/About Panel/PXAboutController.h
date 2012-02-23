//
//  PXAboutController.h
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

@interface PXAboutController : NSViewController
{
  @private
	NSTextView *__unsafe_unretained _creditsView;
	NSTextField *__unsafe_unretained _versionField;
}

@property (nonatomic, unsafe_unretained) IBOutlet NSTextView *creditsView;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *versionField;

@end
