//
//  Employee.h
//  SandPit
//
//  Created by Paul Thomas on 19/12/2014.
//  Copyright (c) 2014 ThomasWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSManagedObject *employer;

@end
