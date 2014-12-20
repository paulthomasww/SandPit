//
//  TestWorker.m
//  SandPit
//
//  Created by Paul Thomas on 20/12/2014.
//  Copyright (c) 2014 ThomasWW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Worker.h"

@interface TestWorker : XCTestCase

@property (nonatomic,retain) NSManagedObjectContext *moc;
@property NSArray *workers;
@property NSArray *firstNames;
@property NSArray *lastNames;

@end

@implementation TestWorker

- (void)setUp {
    [super setUp];
    self.firstNames = [[NSArray alloc]initWithObjects:@"Marina",@"Elodie",@"Zoe",@"Laura",@"Anne",@"Marie",@"Agathe",@"Cathy",@"Connie",@"Jodie",
                       @"Paul",@"Bob",@"Francis",@"Etienne",@"Richard",@"Thomas",@"George",@"Patrick",@"Joseph",@"Bruno",
                       nil];
    self.lastNames = [[NSArray alloc]initWithObjects:@"Thomas",@"Tsirbas",@"Doe",@"Burns",@"Simpson",@"Savuka",@"Kluz",@"Chang",@"Dupont",@"DeNemours",@"Spencer",@"Martin",@"Baker",@"Parker",@"Templar",@"Gomez",@"Sanchez",@"Jones",@"Logan",@"Bardot",
                       nil];
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    self.moc = [[NSManagedObjectContext alloc] init];
    self.moc.persistentStoreCoordinator = psc;
    XCTAssert([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL],@"Boss not created");
    
//    Worker *boss = [self createBoss];
    [self createEmployees];
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Worker"];
    NSError *fecthError = nil;
    self.workers = [self.moc executeFetchRequest:request error:&fecthError];
}

- (void)tearDown {
    self.moc = nil;
    [super tearDown];
}

- (void)testThereAre111Workers {
    XCTAssertEqual([self.workers count], 111);
}

- (void)testThereIsExactlyOneBoss {
    int counter = 0;
    for (Worker *worker in self.workers) {
        if (worker.isBoss) {
            counter++;
        }
    }
    XCTAssert(counter > 0);
    XCTAssertEqual(counter, 1);
}

- (void)testThatTheBossHasTenReporters {
    for (Worker *worker in self.workers) {
        if (worker.isBoss) {
            XCTAssertEqual([worker.reporters count], 10);
        }
    }
}

- (void)testBossNameIsJohnnyClegg {
    XCTAssert([self.workers count] > 0,@"No workers!");
    for (Worker *worker in self.workers) {
        if (worker.isBoss) {
            XCTAssertEqual(worker.firstName, @"Johnny");
            XCTAssertEqual(worker.lastName, @"Clegg");
        }
    }
}

- (void)testThatThereIs10underbosses {
    NSFetchRequest *underbossesRequest = [[NSFetchRequest alloc] initWithEntityName:@"Worker"];
    NSPredicate *underbossesPredicate = [NSPredicate predicateWithFormat:@"manager != nil AND count(reporters) > 0"];
    underbossesRequest.predicate = underbossesPredicate;
    NSError *error = nil;
    NSArray *underbosses = [self.moc executeFetchRequest:underbossesRequest error:&error];
    XCTAssertEqual([underbosses count], 10);
}

- (void)testThatThereIs100underlings {
    NSFetchRequest *underlingsRequest = [[NSFetchRequest alloc] initWithEntityName:@"Worker"];
    NSPredicate *underlingsPredicate = [NSPredicate predicateWithFormat:@"manager != nil AND count(reporters) == 0"];
    underlingsRequest.predicate = underlingsPredicate;
    NSError *error = nil;
    NSArray *underlings = [self.moc executeFetchRequest:underlingsRequest error:&error];
    XCTAssertEqual([underlings count], 100);
}

- (Worker *)createBoss {
    Worker *newBoss = [NSEntityDescription insertNewObjectForEntityForName:@"Worker" inManagedObjectContext:self.moc];
    if (newBoss != nil) {
        newBoss.firstName = @"Johnny";
        newBoss.lastName = @"Clegg";
        newBoss.age = @38;
        
        NSError *savingError = nil;
        
        if ([self.moc save:&savingError]) {
            NSLog(@"Successfully saved boss");
        } else {
            NSLog(@"Failed to save boss. Error: %@",savingError);
        }
    } else {
        NSLog(@"Failed to create boss");
    }
    return newBoss;
}

- (void) createEmployees {
    Worker *boss = [self createBoss];
    for (int i = 0; i < 10; i++) {
        Worker *underboss = [self createUnderboss:boss];
        for (int ii = 0; ii <10; ii++) {
            [self createUnderling:underboss];
        }
    }
}

- (Worker *) createUnderboss:(Worker *)boss {
    Worker *underboss =[NSEntityDescription insertNewObjectForEntityForName:@"Worker" inManagedObjectContext:self.moc];
    if (underboss != nil) {
        underboss.firstName = [self.firstNames objectAtIndex: rand() % 20];
        underboss.lastName = [self.lastNames objectAtIndex: rand() % 20];
        underboss.age = @38;
        underboss.manager = boss;
        [boss addReportersObject:underboss];
        
        NSError *savingError = nil;
        
        if ([self.moc save:&savingError]) {
            NSLog(@"Successfully saved Underboss");
        } else {
            NSLog(@"Failed to save Underboss. Error: %@",savingError);
        }
    } else {
        NSLog(@"Failed to create Underboss");
    }
    return underboss;
}

- (void)createUnderling:(Worker *)underboss {
    Worker *underling = [NSEntityDescription insertNewObjectForEntityForName:@"Worker" inManagedObjectContext:self.moc];
    if (underling != nil) {
        underling.firstName = [self.firstNames objectAtIndex:rand() % 20];
        underling.lastName = [self.lastNames objectAtIndex:rand() % 20];
        underling.age = @20;
        underling.manager = underboss;
        [underboss addReportersObject:underling];

         NSError *savingError = nil;
         
         if ([self.moc save:&savingError]) {
             NSLog(@"Successfully saved Underling");
         } else {
             NSLog(@"Failed to save Underling. Error: %@",savingError);
         }

    } else {
        NSLog(@"Failed to create Underling");
    }
}

@end
