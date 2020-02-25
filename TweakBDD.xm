// MARK: - Settings

static BOOL enabled = YES;

#define kPrefsAppID CFSTR("dev.ayden.ios.tweak.wintermode")
static void loadSettings() {
    NSDictionary *settings = nil;
    CFPreferencesAppSynchronize(kPrefsAppID);
    CFArrayRef keyList = CFPreferencesCopyKeyList(kPrefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (keyList) {
        settings = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, kPrefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
        CFRelease(keyList);
    }
    if (settings && settings[@"Enabled"]) enabled = [settings[@"Enabled"] boolValue];
}

static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    loadSettings();
}

// MARK: - Hooks

%hook BLTBulletinDistributor

- (void)_handleDidPlayLightsAndSirens:(BOOL)didPlayLightsAndSirens forBulletin:(id)bulletin inPhoneSection:(id)phoneSecton transmissionDate:(id)transmissionDate receptionDate:(id)receptionDate fromGizmo:(BOOL)fromGizmo finalReply:(BOOL)finalReply replyToken:(id)replyToken {
    if (enabled) didPlayLightsAndSirens = NO;
    %orig;
}

%end

// MARK: - Initialization

%ctor {
    @autoreleasepool {
        // listen for notifications from settings
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        NULL,
                                        (CFNotificationCallback)settingsChanged,
                                        CFSTR("dev.ayden.ios.tweak.wintermode.changed"),
                                        NULL,
                                        CFNotificationSuspensionBehaviorDeliverImmediately);
   }
}