/* AppController */

#import <Cocoa/Cocoa.h>

@class TMKaleidoscopeView;
@class MyDocument;

@interface AppController : NSObject
{
    IBOutlet TMKaleidoscopeView *kaleidoscopeView;
    IBOutlet MyDocument *myDocument;
}
- (IBAction)shadowAction:(id)sender;
@end
