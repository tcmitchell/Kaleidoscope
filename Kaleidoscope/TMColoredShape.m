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

static const double _60 = M_PI / 3.0;

// Pastel
static const float BRIGHTNESS_BASE = 127.0;
static const float BRIGHTNESS_RANGE = 128.0;

// Bright
// static const float BRIGHTNESS_BASE = 0.0;
// static const float BRIGHTNESS_RANGE = 255.0;

// Dark
// static const float BRIGHTNESS_BASE = 0.0;
// static const float BRIGHTNESS_RANGE = 128.0;

static const int COLOR_STEPS = 32;

#define COLOR_FULL 1
#define COLOR_ASCENDING 2
#define COLOR_DESCENDING 3

@implementation TMColoredShape

- (double)randomDouble
{
  long rndm = random();
  double dmax = pow(2.0, 31.0) - 1;
  return rndm / dmax;
}

- (int)randomIntLessThan:(int)max
{
  return random() % max;
}

- (NSColor *)randomColor
{  
  int i;
  int m[6][3] = { {COLOR_FULL,       COLOR_ASCENDING,  0},
                  {COLOR_DESCENDING, COLOR_FULL,       0},
                  {0,                COLOR_FULL,       COLOR_ASCENDING},
                  {0,                COLOR_DESCENDING, COLOR_FULL},
                  {COLOR_ASCENDING,  0,                COLOR_FULL},
                  {COLOR_FULL,       0,                COLOR_DESCENDING},
  };
  int x = [self randomIntLessThan:(6 * COLOR_STEPS)];
  float c[3];
  int *tuple;
  tuple = m[x / COLOR_STEPS];
  int v = BRIGHTNESS_RANGE * (x % COLOR_STEPS) / COLOR_STEPS;
  for (i = 0; i < 3; i++) {
    switch (tuple[i]) {
    case 0: c[i] = BRIGHTNESS_BASE; break;
    case COLOR_FULL: c[i] = BRIGHTNESS_BASE + BRIGHTNESS_RANGE; break;
    case COLOR_ASCENDING: c[i] = BRIGHTNESS_BASE + v; break;
    case COLOR_DESCENDING: c[i] = BRIGHTNESS_BASE + BRIGHTNESS_RANGE - v; break;
    }
    c[i] /= 255.0;
  }

  return [NSColor colorWithCalibratedRed:c[0] green:c[1] blue:c[2] alpha:0.9];
}

- (id)initWithRadius:(int)radius
{
//   int centerx = [self randomIntLessThan:radius];
//   int centery = [self randomIntLessThan:radius];
  int i;

  self = [super init];
  if (self) {
    numPoints = ([self randomIntLessThan:(MAX_SIDES + 1 - MIN_SIDES)]
                 + MIN_SIDES);
    a = _60 * [self randomDouble];
    r = [self randomDouble];
    r = 30 + (radius - 30) * r * (0.5 + 0.5 * r);
    float xc = (float) (r * cos(a));
    float yc = (float) (r * sin(a));
    points = calloc(numPoints, sizeof(NSPoint));
    for (i = 0; i < numPoints; i++) {
      double angle = i * M_PI * 2.0 / numPoints;
      double radius = 5 + [self randomDouble] * 30;
      points[i].x = (int) ((radius * cos(angle)) + xc);
      points[i].y = (int) ((radius * sin(angle)) + yc);
    }
    color = [self randomColor];
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
