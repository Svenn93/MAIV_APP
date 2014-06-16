//
//  MPChandler.h
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface MPChandler : NSObject<MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *browserSession;
@property (nonatomic, strong) MCSession *advertiseSession;
@property (nonatomic, strong) MCNearbyServiceBrowser *browser;
@property (nonatomic, strong) MCNearbyServiceAdvertiser *advertiser;
@property (nonatomic, strong) NSArray *ArrayInvitationhandler;
@property (nonatomic)BOOL shouldInvite;
@property (nonatomic, strong) NSString *servicetype;
- (void)setupServiceType:(NSString *)servicetype;
- (void)setupPeerWithDisplayName:(NSString *)displayName;
- (void)setupSession;
- (void)setupBrowser;
- (void)advertiseSelf:(BOOL)advertise;
@end
