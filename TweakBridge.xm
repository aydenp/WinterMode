@interface PSListController : UIViewController
- (NSArray *)loadSpecifiersFromPlistName:(NSString *)arg1 target:(id)arg2 bundle:(NSBundle *)arg3;
@end

@interface COSSettingsListController : PSListController
@end

%hook COSSettingsListController

-(NSArray *)additionalSpecifiers {
    NSMutableArray *specifiers = [[self loadSpecifiersFromPlistName:@"Bridge" target:self bundle:[NSBundle bundleWithPath:@"/Library/Application Support/Ayden Panhuyzen/Winter Mode/BridgePrefs.bundle"]] mutableCopy];
    [specifiers addObjectsFromArray:%orig];
    return specifiers;
}

%end
