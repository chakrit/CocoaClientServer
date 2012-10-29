//
//  ClientInfo.m
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import "ClientInfo.h"


@interface ClientInfo () <NSConnectionDelegate> @end

@implementation ClientInfo

+ (id)clientInfoWithConnection:(NSConnection *)connection {
    ClientInfo *info = [[ClientInfo alloc] init];
    info->_connection = connection;
    info->_client = [connection rootObject];

    return info;
}

- (id)init {
    if (self = [super init]) {
        _connection = nil;
        _client = nil;
        _isAlive = NO;
    }
    return self;
}


- (void)setConnection:(NSConnection *)connection {
    if (_connection == connection) return;

    [self willChangeValueForKey:@"connection"];
    _connection = connection;

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    [center addObserver:self
               selector:@selector(connectionDidDie:)
                   name:NSConnectionDidDieNotification
                 object:connection];

    [self didChangeValueForKey:@"connection"];
}


- (void)connectionDidDie:(NSNotification *)notif {
    NSConnection *conn = [notif object];
    if (conn == _connection)
        _isAlive = NO;
}

@end
