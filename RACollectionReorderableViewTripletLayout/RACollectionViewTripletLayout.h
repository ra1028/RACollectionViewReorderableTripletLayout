//
//  RACollectionViewTripletLayout.h
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/25/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RACollectionViewTripletLayoutStyleSquare CGSizeZero

@protocol RACollectionViewDelegateTripletLayout <UICollectionViewDelegateFlowLayout>

@optional

- (CGSize)sizeForLargeItem:(UICollectionView *)collectionView; //Default to automaticaly grow square !
- (UIEdgeInsets)insetsForSection:(UICollectionView *)collectionView; //Default is (0, 0, 0, 0).

@end



@interface RACollectionViewTripletLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<RACollectionViewDelegateTripletLayout> delegate;
@property (nonatomic, assign, readonly) CGSize largeCellSize;
@property (nonatomic, assign, readonly) CGSize smallCellSize;

@end
