//
//  ClipView.m
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "ClipView.h"

@implementation ClipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake((frame.size.width - 180)/2, 0, 180, 152)];
        self.scrollview.clipsToBounds = NO;
        [self.scrollview setPagingEnabled:YES];
        [self addSubview:self.scrollview];
        
        int xPos = self.scrollview.frame.size.width ;
        
        for (int i = 0; i < [self.arrOutlines count]; i++) {
            NSDictionary *dict = [self.arrOutlines objectAtIndex:i];
            UIImage *outline = [UIImage imageNamed:[dict valueForKey:@"outlinepath"]];
            UIImageView *iv = [[UIImageView alloc]initWithImage:outline];
            [iv setFrame:CGRectMake((xPos - outline.size.width)/2, self.scrollview.frame.size.height - outline.size.height, outline.size.width, outline.size.height)];
            [self.scrollview addSubview:iv];
            xPos = xPos + 360;
            NSLog(@"COntent size: %d", xPos);
        }
        
        [self.scrollview setContentSize:CGSizeMake(xPos/2 - 92, self.scrollview.frame.size.height)];
        [self.scrollview setDelegate:self];
        self.currentPage = 0;
        self.totalPages = (int)self.arrOutlines.count;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andOutlines:(NSMutableArray *)arrOutlines
{
    self.arrOutlines = arrOutlines;
    return [self initWithFrame:frame];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self pointInside:point withEvent:event] ? self.scrollview : nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.currentPage = (int)page;
}

- (void)setPage:(int)newpage
{
    if(newpage >= 0 && newpage < self.totalPages)
    {
        self.currentPage = newpage;
    }
    [self.scrollview setContentOffset:CGPointMake(self.scrollview.frame.size.width*self.currentPage, 0.0f) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
