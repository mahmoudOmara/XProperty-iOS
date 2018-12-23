#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BMALabeledRangeSlider.h"
#import "BMALabeledSlider.h"
#import "BMALabeledSliderConfiguring.h"
#import "BMARangeFormatter.h"
#import "BMARangeSlider.h"
#import "BMASlider.h"
#import "BMASliderLiveRenderingStyle.h"
#import "BMASliderReusableXibControl.h"
#import "BMASliderStyling.h"

FOUNDATION_EXPORT double BMASlidersVersionNumber;
FOUNDATION_EXPORT const unsigned char BMASlidersVersionString[];

