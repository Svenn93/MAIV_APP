//
//  KiesGebouwView.m
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "KiesGebouwView.h"
#import "UIColor+EnRoute.h"
#import "UIView+EnRoute.h"

@implementation KiesGebouwView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self fixTitleBar];
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        
        UIImage *image = [UIImage imageNamed:@"gebouwKiesBg"];
        UIImageView *bgView = [[UIImageView alloc]initWithImage:image];
        [bgView setFrame:CGRectMake(0, frame.size.height- 64 - image.size.height, image.size.width, image.size.height)];
        
        UIImage *btnImage1 = [UIImage imageNamed:@"kiesUit"];
        UIImage *btnImage2 = [UIImage imageNamed:@"kiesIn"];
        UIButton *btnKies = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnKies setImage:btnImage1 forState:UIControlStateNormal];
        [btnKies setImage:btnImage2 forState:UIControlStateHighlighted];
        [btnKies setFrame:CGRectMake((frame.size.width - btnImage1.size.width)/2, 360, btnImage1.size.width, btnImage1.size.height)];
        [btnKies addTarget:self action:@selector(kiesBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *btnLinksImage = [UIImage imageNamed:@"wijzerLinks"];
        UIImage *btnRechtsImage = [UIImage imageNamed:@"wijzerRechts"];
        UIButton *btnLinks = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *btnRechts = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnLinks setImage:btnLinksImage forState:UIControlStateNormal];
        [btnRechts setImage:btnRechtsImage forState:UIControlStateNormal];
        [btnLinks setFrame:CGRectMake(frame.size.width/2 - btnLinksImage.size.width - 7, 221, btnLinksImage.size.width, btnLinksImage.size.height)];
        [btnRechts setFrame:CGRectMake(frame.size.width - btnRechtsImage.size.width - 39, 222, btnRechtsImage.size.width, btnRechtsImage.size.height)];
        
        btnLinks.tag = 1;
        btnRechts.tag = 2;
        
        [btnLinks addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btnRechts addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRechts];
        [self addSubview:btnLinks];
        

        self.clipview = [[ClipView alloc]initWithFrame:CGRectMake(0, 60, frame.size.width, 154) andOutlines:self.arrOutlines];
        [self.clipview addSubview:self.scrollview];
        
        [self addSubview:self.clipview];
        [self addSubview:bgView];
        [self addSubview:btnKies];
    }
    return self;
}

- (void)kiesBtnTapped:(id)sender
{
    NSLog(@"Kies button tapped %@", [self.clipview.arrOutlines objectAtIndex:self.clipview.currentPage]);
    
}

- (instancetype)initWithFrame:(CGRect)frame andOutlines:(NSMutableArray *)outlines
{
    self.arrOutlines = outlines;
    return [self initWithFrame:frame];
}

- (void)btnTapped:(id)sender
{
    int direction = (int)((UIButton *)sender).tag;
    NSLog(@"Links of rechts tapped %d", direction);
    
    if(direction == 1)
    {
        [self.clipview setPage:self.clipview.currentPage-1];
    }else{
        [self.clipview setPage:self.clipview.currentPage+1];
    }
    
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
