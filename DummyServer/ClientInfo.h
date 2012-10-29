//
//  ClientInfo.h
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Conversation.h"


@interface ClientInfo : NSObject

@property (strong, readonly) NSConnection *connection;
@property (strong, readonly) id<ClientObj> client;
@property (readonly) BOOL isAlive;

+ (id)clientInfoWithConnection:(NSConnection *)connection;

@end
