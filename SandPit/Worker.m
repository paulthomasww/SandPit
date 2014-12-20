//
//  Worker.m
//  SandPit
//
//  Created by Paul Thomas on 20/12/2014.
//  Copyright (c) 2014 ThomasWW. All rights reserved.
//

#import "Worker.h"
#import "Worker.h"


@implementation Worker

@dynamic age;
@dynamic firstName;
@dynamic lastName;
@dynamic manager;
@dynamic reporters;

-(BOOL)isBoss {
    BOOL isBoss = NO;
    if (self.manager == nil) {
        isBoss = YES;
    }
    return isBoss;
}

@end
