/* -*- Mode:ObjC -*- */
/* TMKaleidocopeView */

#import <Cocoa/Cocoa.h>

@class MyDocument;

@interface TMKaleidoscopeView : NSView
{
  NSMutableArray *shapes;
  IBOutlet MyDocument *document;
}
@end
