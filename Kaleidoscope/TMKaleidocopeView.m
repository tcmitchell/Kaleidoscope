#import "TMKaleidocopeView.h"
#import "TMColoredShape.h"

static const double NSHAPES_PER_PIXEL = .0005;

@implementation TMKaleidocopeView

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
  [self setNeedsDisplay:YES];
}

- (void)fillShapes:(int)newRadius
{
  int i;
  TMColoredShape *shape;
  int numShapes;

  numShapes = (int)lround(NSHAPES_PER_PIXEL * newRadius * newRadius * M_PI);
  [shapes removeAllObjects];
  for (i = 0; i < numShapes; i++)
    {
      shape = [[TMColoredShape alloc] initWithRadius:newRadius - 25];
      [shapes addObject:shape];
      [shape release];
    }
}

- (id)initWithFrame:(NSRect)frameRect
{
  if ((self = [super initWithFrame:frameRect]) != nil) {
    shapes = [[NSMutableArray arrayWithCapacity:40] retain];
  }
  return self;
}

- (void)drawRect:(NSRect)rect
{
  NSRect bounds;
  NSAffineTransform *transform;

  /* fill with black */
  bounds = [self bounds];
  [[NSColor blackColor] set];
  [NSBezierPath fillRect:bounds];

  int radius = MIN(bounds.size.width, bounds.size.height) / 2;
  [self fillShapes:radius];

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
      [clip setClip];
      [shapes makeObjectsPerformSelector:@selector(draw)];
      [NSGraphicsContext restoreGraphicsState];
    }
    [transform scaleXBy:1.0 yBy:-1.0];
  }
}

@end
