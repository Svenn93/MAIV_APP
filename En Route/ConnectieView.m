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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(peerDidChangeState:) name:@"peerDidChangeState" object:nil];
    }
    return self;
}

- (void)updatePeers
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSArray *arrConnPeers = (NSArray *)(MPChandler *)appDelegate.mpcHandler.browserSession.connectedPeers;
    
    int yPos = 100;
    for(int i = 0; i<[arrConnPeers count]; i++)
    {
        NSLog(@"Connected peer: %@", arrConnPeers[i]);
        UIImage *imageLabel = [UIImage imageNamed:@"labelBg"];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(35, yPos, imageLabel.size.width, imageLabel.size.height)];
        MCPeerID *peerID = (MCPeerID *)(arrConnPeers[i]);
        [lbl setBackgroundColor:[UIColor colorWithPatternImage:imageLabel]];
        [lbl setText: peerID.displayName];
        [self addSubview:lbl];
        yPos += 77;
    }
}

- (void)peerDidChangeState: (NSNotification *)notification
{
    NSLog(@"Notification: %@", notification);
    [self updatePeers];
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
