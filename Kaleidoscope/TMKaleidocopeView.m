#import "TMKaleidocopeView.h"

@implementation TMKaleidocopeView

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect]) != nil) {
		// Add initialization code here
	}
	return self;
}

- (void)drawRect:(NSRect)rect
{
  NSBezierPath *path;
  NSPoint p;

  path = [[NSBezierPath alloc] init];
  [path setLineWidth:2.0];
  p.x = 10;
  p.y = 10;
  [path moveToPoint:p];
  p.y = 50;
  [path lineToPoint:p];
  p.x = 50;
  [path lineToPoint:p];
  p.y = 10;
  [path lineToPoint:p];
  [path closePath];

  [[NSColor blackColor] set];
  [path stroke];
  [[NSColor redColor] set];
  [path fill];
  [path release];
}

@end
