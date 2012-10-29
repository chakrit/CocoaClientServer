//
//  Client.m
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import "Client.h"
#import "Conversation.h"
#import "Shared.h"


@interface Client () <NSConnectionDelegate> @end

@implementation Client {
    NSConnection *_connection;
    ClientObj *_client;
}

- (void)start {
    _client = [[ClientObj alloc] init];

    _connection = [NSConnection connectionWithRegisteredName:NAME host:nil];
    [_connection setDelegate:self];
    [_connection setRootObject:_client];

    id<ServerObj> server = (id)[_connection rootProxy];
    [server registerClient:_client];

    // add server chatter
    NSTimer *timer = [NSTimer timerWithTimeInterval:PING_DELAY
                                             target:self
                                           selector:@selector(chatterTimerDidFire:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)chatterTimerDidFire:(NSTimer *)timer {
    @try {
        [_client pingServer];
    } @catch (NSException *e) {
        NSLog(@"EXCEPTION: %@", e);
    }
}

@end
