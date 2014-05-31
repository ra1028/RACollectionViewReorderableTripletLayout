//
//  RAViewController.m
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/25/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RAViewController.h"

@interface UICollectionViewCell (RAViewController)

@property (nonatomic, strong) UIView *cover;

@end

@implementation UICollectionViewCell (RAViewController)

@dynamic cover;

- (void)setHighlighted:(BOOL)highlighted
{
    [self.cover removeFromSuperview];
    self.cover = nil;
    if (highlighted) {
        self.cover = [[UIView alloc] initWithFrame:self.bounds];
        self.cover.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.cover];
    }
}

@end



@interface RAViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RAViewController
{
    NSInteger numberOfCells;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    numberOfCells = 50;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return numberOfCells;
}

- (CGFloat)itemSpacingForLineItems:(UICollectionView *)collectionView
{
    return 5.f;
}

- (CGFloat)lineSpacingForLineItems:(UICollectionView *)collectionView
{
    return 5.f;
}

- (UIEdgeInsets)insetsForSection:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(5.f, 0, 5.f, 0);
}

- (CGSize)sizeForLargeItem:(UICollectionView *)collectionView
{
    return RACollectionViewTripletLayoutStyleSquare; //same as default !
}

- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(50.f, 0, 50.f, 0); //Sorry, horizontal scroll is not supported now.
}

- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(64.f, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHue:(indexPath.item / 52.f) * 1.f saturation:1.f brightness:1.f alpha:1.f];
    
    for (id label in cell.contentView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            [(UILabel *)label removeFromSuperview];
        }
    }
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    numberLabel.textColor = [UIColor blackColor];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    numberLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView insertSubview:numberLabel atIndex:0];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (numberOfCells == 1) {
        return;
    }
    numberOfCells--;
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}



- (IBAction)addCell:(UIBarButtonItem *)sender
{
    numberOfCells++;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}

@end
