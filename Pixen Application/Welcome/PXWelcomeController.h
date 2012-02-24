//
//  PXWelcomeController.h
//  Pixen
//
//  Copyright 2011-2012 Pixen Project. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface PXWelcomeController : NSWindowController
{
  @private
	WebView *__unsafe_unretained _webView;
}

@property (nonatomic, unsafe_unretained) IBOutlet WebView *webView;

+ (id)sharedWelcomeController;

@end
