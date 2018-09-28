import UIKit
import Flutter
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
	override func application(
			_ application: UIApplication,
			didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
	) -> Bool {
		GeneratedPluginRegistrant.register(with: self)
		MSAppCenter.start("8e5f593c-a6e4-4cc4-b924-3771666f5afe", withServices: [
			MSAnalytics.self,
			MSCrashes.self
		])

		return super.application(application, didFinishLaunchingWithOptions: launchOptions)
	}
}
