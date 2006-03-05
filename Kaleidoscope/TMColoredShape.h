/* -*- Mode:ObjC -*- */
//
//  TMColoredShape.h
//  Kaleidoscope
//
//  Created by Tom Mitchell on 3/4/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMColoredShape : NSObject {
  int numPoints;
  NSPointArray points;
  NSColor *color;
}

- (id)initWithMaxRadius:(int)radius;
- (void)draw;

@end
