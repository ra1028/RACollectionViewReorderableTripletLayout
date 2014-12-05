RACollectionViewReorderableTripletLayout
=======================

#### The custom collectionView layout that can perform reordering of cells by dragging it.

### <span style="color:red;">I created a new awesome UICollectionView reorderable layout !</span>
#### <span style="color:red;">[Check it out !!](https://github.com/ra1028/RAReorderableLayout)</span>

## Features
- Reorder cells by long pressing and dragging it !
- You can Receive notification to some dragging events.
- Sorry, has not supported horizontal scroll collection view.
- ~~Sections two or more are also not supported...~~   __Supported !__

#### Please, send me pull request !


## Screen shots
![screen shot1](https://github.com/ra1028/RACollectionViewReorderableTripletLayout/raw/master/Assets/screenshot1.png)
![screen shot2](https://github.com/ra1028/RACollectionViewReorderableTripletLayout/raw/master/Assets/screenshot2.png)


## Animation
![animated gif](https://github.com/ra1028/RACollectionViewReorderableTripletLayout/raw/master/Assets/animation.gif)


## Installation

RACollectionViewReorderableTripletLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "RACollectionViewReorderableTripletLayout"


## Usage
Add RACollectionViewReorderableTripletLayout to your collection view, then set delegate and datasource.
```Objective-C
self.collectionView.delegate = self;
self.collectionView.dataSource = self;
```


## Delegates and Datasource
#### TripletLayout
```Objective-C
- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section; //Default to automaticaly grow square !
- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView;
- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView;
- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView;
- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView;
```
#### ReorderableTripletLayout
```Objective-C
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;
```

```Objective-c
- (CGFloat)reorderingItemAlpha:(UICollectionView * )collectionview; //Default 0.
- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView; //Sorry, has not supported horizontal scroll.
- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView;

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
```


## License
RACollectionViewReorderableTripletLayout is available under the MIT license. See the LICENSE file for more info.

