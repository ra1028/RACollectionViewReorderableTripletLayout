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

- (CGSize)sizeForLargeItemsInCollectionView:(UICollectionView *)collectionView; //Default to automaticaly grow square !
- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView;
- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView;
- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView;

@end



@interface RACollectionViewTripletLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<RACollectionViewDelegateTripletLayout> delegate;
@property (nonatomic, assign, readonly) CGSize largeCellSize;
@property (nonatomic, assign, readonly) CGSize smallCellSize;

//needs override
- (BOOL)shouldUpdateAttributesArray;

@end
