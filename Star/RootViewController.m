//
//  RootViewController.m
//  Star
//
//  Created by Hristo Hristov on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "HHRateSlider.h"

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
  HHRateSlider* rateSlider = [[HHRateSlider alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
  
  [self setView:rateSlider];
  
  [rateSlider addTarget:self 
                 action:@selector(ratingChanged:) 
       forControlEvents:UIControlEventValueChanged];
  
  [rateSlider release];
  
  
  UILabel* ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
  
  [ratingLabel setTextAlignment:UITextAlignmentCenter];
  
  [ratingLabel setFont:[UIFont boldSystemFontOfSize:50.0f]];
  
  [ratingLabel setCenter:CGPointMake( 240, 150)];
  
  [[self view] addSubview:ratingLabel];
  
  [ratingLabel release];
  
}

- (void)ratingChanged:(HHRateSlider*)slider {
  UILabel* ratingLabel = [[[self view] subviews] lastObject];
  
  [ratingLabel setText:[NSString stringWithFormat:@"%1.1f",[slider rating]]];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
