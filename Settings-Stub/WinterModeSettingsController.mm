#import <UIKit/UIKit.h>
#import "Headers.h"

@interface WinterModeSettingsController : PSListController
@end

@implementation WinterModeSettingsController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"WinterMode";
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSMutableArray *specifiers = [[self loadSpecifiersFromPlistName:@"WinterMode" target:self] mutableCopy];
		_specifiers = specifiers;
	}
	return _specifiers;
}

@end
