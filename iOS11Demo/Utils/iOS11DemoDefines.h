//
//  iOS11DemoDefines.h
//  iOS11Demo
//
//  Created by wintel on 2017/10/9.
//  Copyright © 2017年 wintel. All rights reserved.
//

#ifndef iOS11DemoDefines_h
#define iOS11DemoDefines_h

#define RGB(R, G ,B) [UIColor colorWithRed:((R) / 255.0) green:((G) / 255.0) blue:((B) / 255.0) alpha:1]
#define RGBA(R, G , B, A) [UIColor colorWithRed:((R) / 255.0) green:((G) / 255.0) blue:((B) / 255.0) alpha:(A)]

#import "AppDelegate.h"

#define iOS11DemoAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#endif /* iOS11DemoDefines_h */


