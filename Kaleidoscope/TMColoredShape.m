//
//  TMColoredShape.m
//  Kaleidoscope
//
//  Created by Tom Mitchell on 3/4/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "TMColoredShape.h"

static const int MIN_SIDES = 3;
static const int MAX_SIDES = 7;

@implementation TMColoredShape

- (id)initWithMaxRadius:(int)radius
{
  int center = random() % radius + 50;

  self = [super init];
  if (self) {
    numPoints = 4;
    points = calloc(numPoints, sizeof(NSPoint));
    color = [[NSColor redColor] retain];

    points[0].x = -10 + center;
    points[0].y = -10 + center;
    points[1].x = 10 + center;
    points[1].y = -10 + center;
    points[2].x = 10 + center;
    points[2].y = 10 + center;
    points[3].x = -10 + center;
    points[3].y = 10 + center;
  }
  return self;
}

- (void)draw
{
  NSBezierPath *path;
  int i;

  path = [[NSBezierPath alloc] init];
  [path setLineWidth:2.0];
  [path moveToPoint:points[0]];
  for (i = 1; i < numPoints; i++) {
    [path lineToPoint:points[i]];
  }
  [path closePath];

  [[NSColor blackColor] set];
  [path stroke];
  [color set];
  [path fill];

  [path release];
}

@end
