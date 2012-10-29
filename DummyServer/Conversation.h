//
//  Conversation.h
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ClientObj;


@protocol ServerObj

- (void)registerClient:(id<ClientObj>)client;

- (NSString *)ping;
- (void)pingAllClients;

@end


@protocol ClientObj

- (void)registerServer:(id<ServerObj>)server;

- (NSString *)ping;
- (void)pingServer;

@end


@interface ServerObj : NSObject <ServerObj> @end

@interface ClientObj : NSObject <ClientObj> @end
