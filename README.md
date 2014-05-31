RACollectionViewReorderableTripletLayout
=======================

#### The custom collectionView layout that can perform reordering of cells by dragging it


## Features
・ Reorder cells by long pressing and dragging it !
・ You can Receive notification to some dragging events.
・ Sorry, has not supported horizontal scroll collection view.


## Screen shots
![screen shot](https://github.com/ra1028/RACollectionViewReorderableTripletLayout/raw/master/Assets/screenshot.png)


## Animation
![animated gif](https://github.com/ra1028/RACollectionViewReorderableTripletLayout/raw/master/Assets/animation.gif)


## Usage
Add RACollectionViewReorderableTripletLayout to your collection view, then set delegate and datasource.
```Objective-C
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
```


## Delegates and Datasource
#### TripletLayout
```Objective-C
    - (CGSize)sizeForLargeItem:(UICollectionView *)collectionView; //Default to automaticaly grow square !
    - (CGFloat)itemSpacingForLineItems:(UICollectionView *)collectionView; //Default is 0.
    - (CGFloat)lineSpacingForLineItems:(UICollectionView *)collectionView; //Default is 0.
    - (UIEdgeInsets)insetsForSection:(UICollectionView *)collectionView; //Default is (0, 0, 0, 0).
```
#### ReorderableTripletLayout
```Objective-C
    - (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;
    - (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;

    - (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
    - (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;
```

```Objective-c
    - (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView; //Sorry, has not supported horizontal scroll.
    - (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView;

    - (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
    - (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
    - (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
    - (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
```


## License
RACollectionViewReorderableTripletLayout is released under the MIT License, see LICENSE.txt.
