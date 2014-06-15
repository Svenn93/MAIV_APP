//
//  ClipView.h
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClipView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong)NSMutableArray *arrOutlines;
@property (nonatomic)int currentPage;
@property (nonatomic)int totalPages;
- (void)setPage:(int)newpage;
- (instancetype)initWithFrame:(CGRect)frame andOutlines:(NSMutableArray *)arrOutlines;
@end
