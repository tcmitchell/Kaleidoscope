/* -*- Mode:ObjC -*- */
//
//  MyDocument.h
//  Kaleidoscope
//
//  Created by Tom Mitchell on 3/12/06.
//  Copyright __MyCompanyName__ 2006 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
  BOOL shadowed;
}

- (BOOL)shadowed;
- (void)setShadowed:(BOOL)flag;

@end
