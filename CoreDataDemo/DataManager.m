//
//  DataManager.m
//  CoreDataDemo
//
//  Created by 马少洋 on 16/5/12.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "Model.h"




@interface DataManager()

@property  (nonatomic,retain)NSManagedObjectContext * managerObjectContext;
@property (nonatomic,retain)NSManagedObjectModel * managerObjectModel;
@property (nonatomic,retain)NSPersistentStoreCoordinator * persistentStoreCoordinator;

@end


static DataManager * shareSigle = nil;
@implementation DataManager


+ (instancetype)manager{
    if (!shareSigle) {
        shareSigle = [[self alloc]init];
    }
    return shareSigle;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self createMabagerContext];
    }
    return self;
}

- (void)createMabagerContext{
    //获取momd路径
    NSString * path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"momd"];
    self.managerObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managerObjectModel];
    NSString * sqLitePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/data.sqlite"];
    NSPersistentStore * store = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqLitePath] options:nil error:nil];
    if (!store) {
        NSLog(@"创建数据库失败");
    }
    self.managerObjectContext = [[NSManagedObjectContext alloc]init];
    self.managerObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}
//增删查改
- (BOOL)instertModel:(NSString *)name{
    if (!name) {
        return NO;
    }
    Model * model = [NSEntityDescription insertNewObjectForEntityForName:@"Works" inManagedObjectContext:self.managerObjectContext];
    model.name = name;
    return [self save];
}
- (NSArray *)fetchModel:(NSString *)name{

    NSFetchRequest * fetch = [[NSFetchRequest alloc]init];
    fetch.entity = [NSEntityDescription entityForName:@"Works" inManagedObjectContext:self.managerObjectContext];
    if (name) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name like %@",name];
        fetch.predicate = predicate;
    }

    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    fetch.sortDescriptors = @[sort];
    NSArray * array = [self.managerObjectContext executeFetchRequest:fetch error:nil];
    for (Model * model in array) {
        NSLog(@"%@",model.name);
    }
    return array;
}
- (BOOL)upDataModel:(NSString *)name{


    NSArray * array = [self fetchModel:name];
    for (Model * model in array) {
        NSLog(@"%@",model.name);
        model.name = @"小明";
    }
    return [self save];
}
- (BOOL)deteleModel:(NSString *)name{
     NSArray * array = [self fetchModel:name];
    for (Model * model in array) {
        [self.managerObjectContext deleteObject:model];
    }
    return [self save];
}
- (BOOL)save{
    NSError * error = nil;
    return [self.managerObjectContext save:&error];
}

@end
