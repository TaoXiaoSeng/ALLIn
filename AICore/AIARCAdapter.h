//
//  AIARCAdapter.h
//  AllIn
//
//  Created by xiaoseng on 10/29/13.
//  Copyright (c) 2013 xiaoseng. All rights reserved.
//

#ifndef AIARCAdapter_h
#define AIARCAdapter_h


//-fno-objc-arc
//-fobjc-arc
#if __has_feature(objc_arc)
#define AI_PROPERT_RETAIN                  strong
#define AI_PROPERT_ASSIGN                  weak
#define AI_DECLARE_WEAK                    __weak
#define AI_AUTORELEASE_POOL_BEGIN(m)       @autoreleasepool {
#define AI_AUTORELEASE_POOL_END(m)         }
#define AI_AUTORELEASE(obj)                (obj)
#define AI_RETAIN(obj)                     (obj)
#define AI_RELEASE(obj)                    (obj)
#define AI_RETAIN_IN_AUTORELEASE_POOL(obj) (obj)
#define AI_DISPATCH_RETAIN(obj)            (obj)
#define AI_DISPATCH_RELEASE(obj)           (obj)
#define AI_BRIDGING_RETAIN(obj)            CFBridgingRetain((obj))
#define AI_BRIDGING_RELEASE(obj)           CFBridgingRelease((obj))
#define AI_SUPER_DEALLOC
#define AI_INIT_REDIRECT_SELF              return (self = nil)
#else
#define AI_PROPERT_RETAIN                  retain
#define AI_PROPERT_ASSIGN                  assign
#define AI_DECLARE_WEAK
#define AI_AUTORELEASE_POOL_BEGIN(m)       { NSAutoreleasePool * m##_pool = [[NSAutoreleasePool alloc] init];
#define AI_AUTORELEASE_POOL_END(m)         [m##_pool release]; }
#define AI_AUTORELEASE(obj)                [(obj) autorelease]
#define AI_RETAIN(obj)                     [(obj) retain]
#define AI_RELEASE(obj)                    [(obj) release]
#define AI_RETAIN_IN_AUTORELEASE_POOL(obj) [[(obj) retain] autorelease]
#define AI_DISPATCH_RETAIN(obj)            dispatch_retain((obj))
#define AI_DISPATCH_RELEASE(obj)           dispatch_release((obj))
#define AI_BRIDGING_RETAIN(obj)            CFBridgingRetain((obj))
#define AI_BRIDGING_RELEASE(obj)           CFBridgingRelease((obj))
#define AI_SUPER_DEALLOC                   [super dealloc]
#define AI_INIT_REDIRECT_SELF              AI_AUTORELEASE(self); return (self = nil)
#endif


#endif
