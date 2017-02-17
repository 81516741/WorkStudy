//
//  AppDelegate.h
//  baiduditu
//
//  Created by yh on 16/4/5.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow * _window;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

