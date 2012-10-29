//
//  Server.m
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import "Server.h"
#import "Conversation.h"
#import "Shared.h"


@interface Server () <NSConnectionDelegate> @end

@implementation Server {
    NSConnection *_connection;
    ServerObj *_server;
}

- (void)start {
    _server = [[ServerObj alloc] init];

    _connection = [NSConnection serviceConnectionWithName:NAME
                                               rootObject:_server];
    [_connection setDelegate:self];
    [_connection setRootObject:_server];

    // start client keepalive pings
    NSTimer *keepalive = [NSTimer timerWithTimeInterval:PING_DELAY
                                                 target:self
                                               selector:@selector(keepaliveTimerDidFire:)
                                               userInfo:nil
                                                repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:keepalive
                                 forMode:NSRunLoopCommonModes];
}


- (void)keepaliveTimerDidFire:(NSTimer *)timer {
    [_server pingAllClients];
}

@end
