//
//  Worker.h
//  SandPit
//
//  Created by Paul Thomas on 20/12/2014.
//  Copyright (c) 2014 ThomasWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Worker;

@interface Worker : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) Worker *manager;
@property (nonatomic, retain) NSSet *reporters;
@end

@interface Worker (CoreDataGeneratedAccessors)

- (void)addReportersObject:(Worker *)value;
- (void)removeReportersObject:(Worker *)value;
- (void)addReporters:(NSSet *)values;
- (void)removeReporters:(NSSet *)values;
- (BOOL)isBoss;

@end
