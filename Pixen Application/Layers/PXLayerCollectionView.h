//
//  PXLayerCollectionView.h
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "PXDeleteCollectionView.h"

@class PXLayerController;

@interface PXLayerCollectionView : PXDeleteCollectionView
{
  @private
	PXLayerController *__unsafe_unretained _layerController;
}

@property (nonatomic, unsafe_unretained) PXLayerController *layerController;

@end
