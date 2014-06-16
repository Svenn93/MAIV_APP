//
//  MPChandler.m
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "MPChandler.h"

@implementation MPChandler

- (void)setupPeerWithDisplayName:(NSString *)displayName {
    self.peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
}

- (void)setupSession {
    self.browserSession = [[MCSession alloc] initWithPeer:self.peerID];
    self.browserSession.delegate = self;
}

- (void)setupServiceType:(NSString *)servicetype
{
    self.servicetype = servicetype;
}

- (void)setupBrowser {
    self.browser = [[MCNearbyServiceBrowser alloc]initWithPeer:self.peerID serviceType:self.servicetype];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
    NSLog(@"START BROWSING");
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showSession) userInfo:nil repeats:YES];
}

- (void)showSession
{
    NSLog(@"DE SESSION: %@", self.browserSession.connectedPeers);
}

- (void)advertiseSelf:(BOOL)advertise {
    if (advertise) {
        self.advertiser = [[MCNearbyServiceAdvertiser alloc]initWithPeer:self.peerID discoveryInfo:nil serviceType:self.servicetype];
        [self.advertiser startAdvertisingPeer];
        self.advertiser.delegate = self;
        
    } else {
        [self.advertiser stopAdvertisingPeer];
        self.advertiser = nil;
    }
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
    invitationHandler(YES, self.browserSession);
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    NSLog(@"Lost connection");
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    NSLog( @"Unable to start browsing for peers. Error: %@", error );
}

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    NSLog(@"Browser found peer ID %@ en session %@",peerID.displayName, self.browserSession);
        if(self.shouldInvite)
    {
        [browser invitePeer:peerID toSession:self.browserSession withContext:nil timeout:30.0];
    }
}

//wordt opgeroepen wanneer de state van de peer veranderd: connected, connecting, not connected
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSDictionary *userInfo = @{ @"peerID": peerID, @"state" : @(state) };
    NSLog(@"De userinfo: %@", userInfo);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"peerDidChangeState" object:nil userInfo:userInfo];
    });
}


- (void) session:(MCSession *)session didReceiveCertificate:(NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL accept))certificateHandler
{
    certificateHandler(YES);
}

//wanneer de peer data binnenkrijgt 
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSDictionary *userInfo = @{ @"data": data,
                                @"peerID": peerID };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MPCDemo_DidReceiveDataNotification"
                                                            object:nil
                                                          userInfo:userInfo];
    });
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    
}
@end
