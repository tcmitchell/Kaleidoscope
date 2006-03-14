/* -*- Mode:ObjC -*- */
/* AppController */

#import <Cocoa/Cocoa.h>

@class MyDocument;
@class TMKaleidoscopeView;

@interface AppController : NSObject
{
  IBOutlet TMKaleidoscopeView *kaleidoscopeView;
  IBOutlet MyDocument *myDocument;
  IBOutlet NSSlider *shapeDensitySlider;
}
- (IBAction)shadowAction:(id)sender;
- (IBAction)densityAction:(id)sender;
@end
