#import "TMKaleidocopeView.h"
#import "TMColoredShape.h"

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

- (void)fillShapes:(int)numShapes
{
  int i;
  TMColoredShape *shape;

//   NSLog(@"fillShapes:%d", numShapes);
  [shapes removeAllObjects];
  for (i = 0; i < numShapes; i++)
    {
      shape = [[TMColoredShape alloc] initWithRadius:500];
      [shapes addObject:shape];
      [shape release];
    }
}

- (id)initWithFrame:(NSRect)frameRect
{
  if ((self = [super initWithFrame:frameRect]) != nil) {
    shapes = [[NSMutableArray arrayWithCapacity:40] retain];
//     [self fillShapes:40];
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

//   NSLog(@"drawRect finds width = %f, height = %f",
//         bounds.size.width, bounds.size.height);
  int radius = ((bounds.size.width > bounds.size.height)
                ? bounds.size.height : bounds.size.width) / 2;
  [self fillShapes:radius];

  transform = [NSAffineTransform transform];
  [transform translateXBy:(bounds.size.width / 2) yBy:(bounds.size.height / 2)];

  NSBezierPath *clip = [NSBezierPath bezierPath];
  NSPoint pt;
  pt.x = 0; pt.y = 0;
  [clip moveToPoint:pt];
  pt.x = radius;
  [clip lineToPoint:pt];
//   pt.x = (float) (2 * radius * cos(M_PI/3));
//   pt.y = (float) (2 * radius * sin(M_PI/3));
  pt.x = (float) (radius * cos(M_PI/3));
  pt.y = (float) (radius * sin(M_PI/3));
  [clip lineToPoint:pt];
  [clip closePath];

//   [transform rotateByRadians:(M_PI / 2)];
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
