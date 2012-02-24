//
//  PXGeneralPreferencesController.h
//  Pixen
//
//  Copyright 2011-2012 Pixen Project. All rights reserved.
//

@interface PXGeneralPreferencesController : NSViewController
{
  @private
	NSTextField *__unsafe_unretained _autoBackupFrequency;
}

@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *autoBackupFrequency;

- (IBAction)switchAutoBackup:(id)sender;
- (IBAction)updateAutoBackup:(id)sender;

@end
