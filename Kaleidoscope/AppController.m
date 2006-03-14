#import "AppController.h"
#import "MyDocument.h"

@implementation AppController

- (void)awakeFromNib
{
  [shapeDensitySlider setFloatValue:[myDocument shapeDensity]];
}

- (IBAction)shadowAction:(id)sender
{
  BOOL newValue = ([sender state] == NSOnState);
  [myDocument setShadowed:newValue];
//   [kaleidoscopeView setNeedsDisplay:YES];
}

- (IBAction)densityAction:(id)sender
{
  [myDocument setShapeDensity:[sender floatValue]];
}

@end
