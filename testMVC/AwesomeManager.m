//
//  AwesomeManager.m
//  testMVC
//
//  Created by Nikita on 15/08/14.
//  Copyright (c) 2014 vigroup. All rights reserved.
//

#import "AwesomeManager.h"

@interface AwesomeManager()

@property (nonatomic, readwrite) NSArray* data;

@end


@implementation AwesomeManager
@synthesize data = m_data;

static AwesomeManager* m_shared;
+ (AwesomeManager*) shared
{
    if (!m_shared)
    {
        m_shared = [AwesomeManager new];
    }
    return m_shared;
}

- (id) init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (NSArray *)data
{
    if (!m_data)
    {
        m_data = @[];
    }
    return m_data;
}


- (void) reload
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAwesomeManagerWillLoad
                                                        object:self
                                                      userInfo:@{kStatus:kSuccess}];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        self.data = [self generateData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kAwesomeManagerDidLoad
                                                                object:nil
                                                              userInfo:@{kStatus:kSuccess}];
        });
        
    });
}

- (NSArray*) generateData
{
    NSMutableArray* _arr = [NSMutableArray new];
    for (NSInteger i = 0; i < 100000; i++)
    {
        AwesomeInfo* _info = [AwesomeInfo new];
        _info.name = [NSString stringWithFormat:@"name %@", @(i)];
        _info.sub = [NSString stringWithFormat:@"rand int %d", rand()%1000];
        [_arr addObject:_info];
    }
    return [NSArray arrayWithArray:_arr];
}


@end
