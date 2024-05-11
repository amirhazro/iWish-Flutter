import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyAq8mCnRcwAf_G8A4OCLRVjm-iUgpYbbro")
    // GMSServices.provideAPIKey("AIzaSyDP69S3UHqE7URbpWGhEqd-QmkfSUffZnU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
