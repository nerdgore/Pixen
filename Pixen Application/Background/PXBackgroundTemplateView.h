//
//  PXBackgroundTemplateView.h
//  Pixen
//

#import <Cocoa/Cocoa.h>

@class PXBackground, PXBackgroundPreviewView;

@interface PXBackgroundTemplateView : NSView
{
  @private
	PXBackground *background;
	IBOutlet NSView *view;
	NSTextField *__unsafe_unretained templateNameField, *__unsafe_unretained templateClassNameField;
	PXBackgroundPreviewView *__unsafe_unretained imageView;
	BOOL _highlighted;
}

@property (nonatomic, strong) PXBackground *background;

@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *templateNameField;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *templateClassNameField;
@property (nonatomic, unsafe_unretained) IBOutlet PXBackgroundPreviewView *imageView;

@property (nonatomic, getter=isHighlighted, assign) BOOL highlighted;

@end
