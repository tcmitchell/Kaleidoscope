#import "TMKaleidocopeView.h"
#import "TMColoredShape.h"

@implementation TMKaleidocopeView

- (void)fillShapes:(int)numShapes
{
  int i;
  TMColoredShape *shape;

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
    shapes = [NSMutableArray arrayWithCapacity:10];
    [self fillShapes:10];
  }
  return self;
}

- (void)drawRect:(NSRect)rect
{
  [shapes makeObjectsPerformSelector:@selector(draw)];
}

@end
