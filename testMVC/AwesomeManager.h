//
//  AwesomeManager.h
//  testMVC
//
//  Created by Nikita on 15/08/14.
//  Copyright (c) 2014 vigroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AwesomeInfo.h"

#define kAwesomeManagerWillLoad @"kAwesomeManagerWillLoad"
#define kAwesomeManagerDidLoad @"kAwesomeManagerDidLoad"

@interface AwesomeManager : NSObject

+ (AwesomeManager*) shared;

@property (nonatomic, readonly) NSArray* data;

- (void) reload;

@end
