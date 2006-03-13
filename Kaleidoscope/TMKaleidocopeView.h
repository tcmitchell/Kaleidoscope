/* -*- Mode:ObjC -*- */
/* TMKaleidocopeView */

#import <Cocoa/Cocoa.h>

@class MyDocument;

@interface TMKaleidocopeView : NSView
{
  NSMutableArray *shapes;
  IBOutlet MyDocument *document;
}
@end
