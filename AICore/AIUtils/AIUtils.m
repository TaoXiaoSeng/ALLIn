//
//  AIUtils.m
//  testI18N
//
//  Created by xiaoseng on 11/4/13.
//  Copyright (c) 2013 xiaoseng. All rights reserved.
//

#import "AIUtils.h"

static const char* jailbreak_apps[] =
{
    "/Applications/Cydia.app",
    "/Applications/blackra1n.app",
    "/Applications/blacksn0w.app",
    "/Applications/greenpois0n.app",
    "/Applications/limera1n.app",
    "/Applications/redsn0w.app",
    NULL,
};

@implementation AIUtils



+ (BOOL)isJailBrokeDevice
{
    // Check whether the jailbreak apps are installed
    for (int i = 0; jailbreak_apps[i] != NULL; ++i)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString
                                                              stringWithUTF8String:jailbreak_apps[i]]])
        {
            return YES;
        }
    }
    
    return NO;
}
@end
