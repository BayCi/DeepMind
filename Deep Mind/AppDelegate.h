//
//  AppDelegate.h
//  Deep Mind
//
//  Created by 妳的小可愛已上線 on 2019/10/21.
//  Copyright © 2019 BayCi Gou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

