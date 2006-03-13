#import "AppController.h"
#import "MyDocument.h"

@implementation AppController

- (IBAction)shadowAction:(id)sender
{
  BOOL newValue = ([sender state] == NSOnState);
  [myDocument setShadowed:newValue];
//   [kaleidoscopeView setNeedsDisplay:YES];
}

@end
