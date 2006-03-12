/* -*- Mode:ObjC -*- */
/* TMKaleidocopeView */

#import <Cocoa/Cocoa.h>

@interface TMKaleidocopeView : NSView
{
  NSMutableArray *shapes;
  BOOL shadow;
}

- (void)setShadow:(BOOL)flag;
- (BOOL)hasShadow;

@end
