//
//  Conversation.m
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import "Conversation.h"
#import "ClientInfo.h"


NSString *CreateUUID() {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef str = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (NSString *)CFBridgingRelease(str);
}


@implementation ServerObj {
    NSMutableArray *_clients;
}

- (id)init {
    if (self = [super init]) {
        _clients = [NSMutableArray arrayWithCapacity:8];
    }
    return self;
}


- (void)registerClient:(id<ClientObj>)client {
    @try {
        [_clients addObject:client];
        [client registerServer:self];
    }
    @catch (NSException *exception) {
        [self invalidateClient:client withException:exception];
    }
}

- (NSString *)ping {
    NSLog(@"Client requested PING");
    return [NSString stringWithFormat:@"PONG"];
}

- (void)pingAllClients {
    NSMutableArray *badClients = [NSMutableArray arrayWithCapacity:4];

    for (id<ClientObj> client in _clients) {
        @try {
            NSLog(@"pinging...");
            NSLog(@"CLIENT REPLY: %@", [client ping]);
        }
        @catch (NSException *exception) {
            [badClients addObject:exception];
        }
    }

    for (id client in badClients) {
        [self invalidateClient:client withException:nil];
    }
}


- (void)invalidateClient:(id)client withException:(NSException *)exception {
    if (exception) NSLog(@"EXCEPTION: %@", exception);
    [_clients removeObject:client];
}

@end


@implementation ClientObj {
    NSString *_id;
    id<ServerObj> _server;
}

- (id)init {
    if (self = [super init]) {
        _id = CreateUUID();
        _server = nil;
    }
    return self;
}

- (void)registerServer:(id<ServerObj>)server {
    _server = server;
}

- (NSString *)ping {
    NSLog(@"Server requested PING");
    return [NSString stringWithFormat:@"PONG %@", _id];
}

- (void)pingServer {
    NSLog(@"SERVER REPLY: %@", [_server ping]);
}

@end
