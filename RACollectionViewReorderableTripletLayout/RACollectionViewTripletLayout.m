//
//  RACollectionViewTripletLayout.m
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/25/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RACollectionViewTripletLayout.h"

@interface RACollectionViewTripletLayout()

@property (nonatomic, assign) NSInteger numberOfCells;
@property (nonatomic, assign) CGFloat numberOfLines;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGSize collectionViewSize;
@property (nonatomic, assign) UIEdgeInsets insets;

@end

@implementation RACollectionViewTripletLayout

#pragma mark - Over ride flow layout methods

- (void)prepareLayout
{
    [super prepareLayout];

    //delegate
    self.delegate = (id<RACollectionViewDelegateTripletLayout>)self.collectionView.delegate;
    //collection view size
    _collectionViewSize = self.collectionView.bounds.size;
    //number of cells, number of lines
    _numberOfCells = 0;
    _numberOfLines = 0;
    for (NSInteger i = 0; i < self.collectionView.numberOfSections; i++) {
        NSInteger numberOfCellsInSection = [self.collectionView numberOfItemsInSection:i];
        _numberOfCells += numberOfCellsInSection;
        _numberOfLines += ceilf((CGFloat)numberOfCellsInSection / 3.f);
        if ((numberOfCellsInSection - 1) % 3 == 0 && (numberOfCellsInSection - 1) % 6 != 0) {
            _numberOfLines -= .5f;
        }
    }
}

- (id<RACollectionViewDelegateTripletLayout>)delegate
{
    return (id<RACollectionViewDelegateTripletLayout>)self.collectionView.delegate;
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = CGSizeMake(_collectionViewSize.width, _numberOfLines * (_largeCellSize.height + _lineSpacing) - _lineSpacing + _insets.top + _insets.bottom);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributesArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.collectionView.numberOfSections; i++) {
        NSInteger numberOfCellsInSection = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < numberOfCellsInSection; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [attributesArray addObject:attributes];
            }
        }
    }
    return  attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //spacing
    _itemSpacing = 0;
    _lineSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(minimumInteritemSpacingForCollectionView:)]) {
        _itemSpacing = [self.delegate minimumInteritemSpacingForCollectionView:self.collectionView];
    } if ([self.delegate respondsToSelector:@selector(minimumLineSpacingForCollectionView:)]) {
        _lineSpacing = [self.delegate minimumLineSpacingForCollectionView:self.collectionView];
    }

    //cellSize
    CGFloat largeCellSideLength = (2.f * (_collectionViewSize.width - _insets.left - _insets.right) - _itemSpacing) / 3.f;
    CGFloat smallCellSideLength = (largeCellSideLength - _itemSpacing) / 2.f;
    _largeCellSize = CGSizeMake(largeCellSideLength, largeCellSideLength);
    _smallCellSize = CGSizeMake(smallCellSideLength, smallCellSideLength);
    if ([self.delegate respondsToSelector:@selector(sizeForLargeItemsInCollectionView:)]) {
        if (!CGSizeEqualToSize([self.delegate sizeForLargeItemsInCollectionView:self.collectionView], RACollectionViewTripletLayoutStyleSquare)) {
            _largeCellSize = [self.delegate sizeForLargeItemsInCollectionView:self.collectionView];
            _smallCellSize = CGSizeMake(_collectionViewSize.width - _largeCellSize.width - _itemSpacing - _insets.left - _insets.right, (_largeCellSize.height / 2.f) - (_itemSpacing / 2.f));
        }
    }
    //insets
    _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([self.delegate respondsToSelector:@selector(insetsForCollectionView:)]) {
        _insets = [self.delegate insetsForCollectionView:self.collectionView];
    }
    
    CGFloat sectionHeight = 0;
    for (NSInteger i = 0; i < indexPath.section; i++) {
        NSInteger cellsCount = [self.collectionView numberOfItemsInSection:i];
        NSInteger lines = ceil((CGFloat)cellsCount / 3.f);
        sectionHeight += lines * (_lineSpacing + _largeCellSize.height);
        if ((cellsCount - 1) % 3 == 0 && (cellsCount - 1) % 6 != 0) {
            sectionHeight -= _smallCellSize.height + _itemSpacing;
        }
    }

    NSInteger line = indexPath.item / 3;
    CGFloat lineSpaceForIndexPath = _lineSpacing * line;
    CGFloat lineOriginY = _largeCellSize.height * line + sectionHeight + lineSpaceForIndexPath + _insets.top;
    CGFloat rightSideLargeCellOriginX = _collectionViewSize.width - _largeCellSize.width - _insets.right;
    CGFloat rightSideSmallCellOriginX = _collectionViewSize.width - _smallCellSize.width - _insets.right;
    
    if (indexPath.item % 6 == 0) {
        attribute.frame = CGRectMake(_insets.left, lineOriginY, _largeCellSize.width, _largeCellSize.height);
    }else if ((indexPath.item + 1) % 6 == 0) {
        attribute.frame = CGRectMake(rightSideLargeCellOriginX, lineOriginY, _largeCellSize.width, _largeCellSize.height);
    }else if (line % 2 == 0) {
        if (indexPath.item % 2 != 0) {
            attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY, _smallCellSize.width, _smallCellSize.height);
        }else {
            attribute.frame =CGRectMake(rightSideSmallCellOriginX, lineOriginY + _smallCellSize.height + _itemSpacing, _smallCellSize.width, _smallCellSize.height);
        }
    }else {
        if (indexPath.item % 2 != 0) {
            attribute.frame = CGRectMake(_insets.left, lineOriginY, _smallCellSize.width, _smallCellSize.height);
        }else {
            attribute.frame =CGRectMake(_insets.left, lineOriginY + _smallCellSize.height + _itemSpacing, _smallCellSize.width, _smallCellSize.height);
        }
    }
    return attribute;
}

@end
