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
@property (nonatomic, assign) NSInteger numberOfLines;
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
    //number of cells
    _numberOfCells = [self.collectionView numberOfItemsInSection:0];
    //number of lines
    _numberOfLines = ceil((CGFloat)_numberOfCells / 3.f);
    //spacing
    _itemSpacing = 0;
    _lineSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(itemSpacingForLineItems:)]) {
        _itemSpacing = [self.delegate itemSpacingForLineItems:self.collectionView];
    } if ([self.delegate respondsToSelector:@selector(lineSpacingForLineItems:)]) {
        _lineSpacing = [self.delegate lineSpacingForLineItems:self.collectionView];
    }
    //insets
    _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([self.delegate respondsToSelector:@selector(insetsForSection:)]) {
        _insets = [self.delegate insetsForSection:self.collectionView];
    }
    //cellSize
    CGFloat largeCellSideLength = (2.f * (_collectionViewSize.width - _insets.left - _insets.right) - _itemSpacing) / 3.f;
    CGFloat smallCellSideLength = (largeCellSideLength - _itemSpacing) / 2.f;
    _largeCellSize = CGSizeMake(largeCellSideLength, largeCellSideLength);
    _smallCellSize = CGSizeMake(smallCellSideLength, smallCellSideLength);
    if ([self.delegate respondsToSelector:@selector(sizeForLargeItem:)]) {
        if (!CGSizeEqualToSize([self.delegate sizeForLargeItem:self.collectionView], RACollectionViewTripletLayoutStyleSquare)) {
            _largeCellSize = [self.delegate sizeForLargeItem:self.collectionView];
        _smallCellSize = CGSizeMake(_collectionViewSize.width - _largeCellSize.width - _itemSpacing - _insets.left - _insets.right, (_largeCellSize.height / 2.f) - (_itemSpacing / 2.f));
        }
    }
}

- (id<RACollectionViewDelegateTripletLayout>)delegate
{
    return (id<RACollectionViewDelegateTripletLayout>)self.collectionView.delegate;
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = CGSizeMake(_collectionViewSize.width, (_numberOfLines * (_largeCellSize.height + _lineSpacing)) - _lineSpacing + _insets.top + _insets.bottom);
    if ((_numberOfCells - 1) % 3 == 0 && (_numberOfCells - 1) % 6 != 0) {
        contentSize = CGSizeMake(_collectionViewSize.width, (_numberOfLines * (_largeCellSize.height + _lineSpacing)) - 2 * _lineSpacing - _smallCellSize.height + + _insets.top + _insets.bottom);
    }
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSInteger i = 0; i < _numberOfCells; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return  attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger line = indexPath.item / 3;
    CGFloat lineSpaceForIndexPath = _lineSpacing * line;
    CGFloat lineOriginY = _largeCellSize.height * line + lineSpaceForIndexPath + _insets.top;
    CGFloat rightSideLargeCellOriginX = _collectionViewSize.width - _largeCellSize.width - _insets.right;
    CGFloat rightSideSmallCellOriginX = _collectionViewSize.width - _smallCellSize.width - _insets.right;
    
    if (indexPath.item == 0) {
        attribute.frame = CGRectMake(_insets.left, _insets.top, _largeCellSize.width, _largeCellSize.height);
    }else if (indexPath.item % 6 == 0) {
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
