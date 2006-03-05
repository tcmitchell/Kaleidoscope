#import "TMKaleidocopeView.h"
#import "TMColoredShape.h"

@implementation TMKaleidocopeView

- (void)fillShapes:(int)numShapes
{
  int i;
  TMColoredShape *shape;

  NSLog(@"fillShapes:%d", numShapes);
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
  /* fill with black */
  NSRect bounds = [self bounds];
  [[NSColor blackColor] set];
  [NSBezierPath fillRect:bounds];

  int radius = ((bounds.size.width > bounds.size.height) ? bounds.size.height : bounds.size.width) / 2;
//   if (radius != currentRadius) {
    [self fillShapes:radius];
//   }

  [shapes makeObjectsPerformSelector:@selector(draw)];
}

@end
