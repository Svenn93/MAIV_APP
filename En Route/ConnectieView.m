//
//  ConnectieView.m
//  En Route
//
//  Created by Sven Lombaert on 15/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "ConnectieView.h"
#import "UIColor+EnRoute.h"
#import "AppDelegate.h"
#import "MPChandler.h"

@implementation ConnectieView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bgImage = [UIImage imageNamed:@"bgConnection"];
        UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
        [bgView setFrame:CGRectMake((frame.size.width - bgImage.size.width)/2, frame.size.height - bgImage.size.height - 72, bgImage.size.width, bgImage.size.height)];
        [self addSubview:bgView];
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        [self updatePeers];
    }
    return self;
}

- (void)updatePeers
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSArray *arrConnPeers = (NSArray *)(MPChandler *)appDelegate.mpcHandler.browserSession.connectedPeers;
    NSLog(@"[CONNECTIEVIEW] arrConnPeers: %@", arrConnPeers);
    if([arrConnPeers count] > 0)
    {
        int yPos = 100;
        for(int i = 0; i<[arrConnPeers count]; i++)
        {
            NSLog(@"Connected peer: %@", arrConnPeers[i]);
            UIImage *imageLabel = [UIImage imageNamed:@"labelBg"];
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(35, yPos, imageLabel.size.width, imageLabel.size.height)];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            MCPeerID *peerID = (MCPeerID *)(arrConnPeers[i]);
            [lbl setBackgroundColor:[UIColor colorWithPatternImage:imageLabel]];
            [lbl setText: peerID.displayName];
            [lbl setFont:[UIFont fontWithName:@"HalloSans" size:20]];
            [lbl setTextColor:[UIColor whiteColor]];
            [self addSubview:lbl];
            
            
            UIImage *imageCheck = [UIImage imageNamed:@"check"];
            UIImageView *checkView = [[UIImageView alloc]initWithImage:imageCheck];
            [checkView setFrame:CGRectMake(234, yPos, imageCheck.size.width, imageCheck.size.height)];
            [self addSubview:checkView];
            yPos += 77;
        }
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
