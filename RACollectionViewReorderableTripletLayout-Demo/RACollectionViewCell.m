//
//  RACollectionViewCell.m
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/27/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RACollectionViewCell.h"

@implementation RACollectionViewCell

- (void)awakeFromNib
{
    [_cover removeFromSuperview];
    _cover = nil;
    _cover = [[UIView alloc] initWithFrame:self.bounds];
    _cover.backgroundColor = [UIColor blackColor];
    _cover.alpha = 0;
    [self.contentView addSubview:_cover];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.cover.alpha = highlighted ? .3f : 0;
}

@end
