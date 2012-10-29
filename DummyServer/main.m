//
//  main.m
//  DummyServer
//
//  Created by Chakrit Wichian on 10/29/12.
//  Copyright (c) 2012 Oozou Ltd.,. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Client.h"
#import "Server.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
#if defined(CLIENT) && CLIENT
        NSMutableArray *clients = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            Client *client = [[Client alloc] init];
            [client start];
            NSLog(@"Client started.");
            [clients addObject:client];
        }
#else
        Server *server = [[Server alloc] init];
        [server start];
        NSLog(@"Server started.");
#endif
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop run];
    }
    
    return 0;
}
