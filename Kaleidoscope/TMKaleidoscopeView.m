#import "TMKaleidoscopeView.h"
#import "TMColoredShape.h"
#import "MyDocument.h"

@implementation TMKaleidoscopeView

- (void)fillShapes:(int)newRadius
{
  int i;
  TMColoredShape *shape;
  int numShapes;
  NSMutableArray *newShapes;

  numShapes = (int)lround([document shapeDensity] * .00001
                          * newRadius * newRadius * M_PI);
  newShapes = [NSMutableArray arrayWithCapacity:numShapes];
  for (i = 0; i < numShapes; i++)
    {
      shape = [[TMColoredShape alloc] initWithRadius:newRadius - 25];
      [newShapes addObject:shape];
      [shape release];
    }

  NSMutableArray *tmpShapes;
  tmpShapes = shapes;
  shapes = [newShapes retain];
  [tmpShapes release];
}

- (void)awakeFromNib
{
  [NSTimer scheduledTimerWithTimeInterval:4.0
           target:self
           selector:@selector(redrawTimerDidFire:)
           userInfo:nil
           repeats:YES];
}

- (void)redrawTimerDidFire:(NSTimer *)aTimer
{
  NSRect bounds;
  int radius;

  bounds = [self bounds];
  radius = MIN(bounds.size.width, bounds.size.height) / 2;
  [self fillShapes:radius];
  [self setNeedsDisplay:YES];
}

- (id)initWithFrame:(NSRect)frameRect
{
  if ((self = [super initWithFrame:frameRect]) != nil) {
    [self redrawTimerDidFire:nil];
  }
  return self;
}

- (void)drawRect:(NSRect)rect
{
  NSRect bounds;
  NSAffineTransform *transform;
  NSShadow *theShadow = nil;

  /* fill with black */
  bounds = [self bounds];
  [[NSColor whiteColor] set];
  [NSBezierPath fillRect:bounds];

  [NSGraphicsContext saveGraphicsState];

  if ([document shadowed]) {
    NSShadow *theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset:NSMakeSize(10.0, -10.0)];
    [theShadow setShadowBlurRadius:3.0];
    [theShadow setShadowColor:[[NSColor blackColor]
                                colorWithAlphaComponent:0.3]];
    [theShadow set];
  }

  int radius = MIN(bounds.size.width, bounds.size.height) / 2;

  transform = [NSAffineTransform transform];
  [transform translateXBy:(bounds.size.width / 2) yBy:(bounds.size.height / 2)];

  NSBezierPath *clip = [NSBezierPath bezierPath];
  NSPoint pt;
  pt.x = 0; pt.y = 0;
  [clip moveToPoint:pt];
  pt.x = radius;
  [clip lineToPoint:pt];
  pt.x = (float) (2 * radius * cos(M_PI/3));
  pt.y = (float) (2 * radius * sin(M_PI/3));
  [clip lineToPoint:pt];
  [clip closePath];

  [transform rotateByRadians:(M_PI / 2)];
  int i, j;
  for (j = 0; j < 2; j++) {
    for (i = 0; i < 3; i++) {
      [transform rotateByRadians:(M_PI * 2.0 / 3.0)];
      [NSGraphicsContext saveGraphicsState];
      [transform concat];
      [clip addClip];
      [shapes makeObjectsPerformSelector:@selector(draw)];
      [NSGraphicsContext restoreGraphicsState];
    }
    [transform scaleXBy:1.0 yBy:-1.0];
  }

  [NSGraphicsContext restoreGraphicsState];
  [theShadow release];
}

@end
