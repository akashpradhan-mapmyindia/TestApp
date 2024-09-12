//
//  AppDelegate.swift
//  TestApp
//
//  Created by rento on 05/09/24.
//

import UIKit
import MapplsAPICore
import MapplsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MapplsAccountManager.setMapSDKKey("597ab3f0f2340fbd862c909abe8f825e")
        MapplsAccountManager.setRestAPIKey("597ab3f0f2340fbd862c909abe8f825e")
        MapplsAccountManager.setClientId("96dHZVzsAuvr7OZFsbmRry55zc0GG5AskbGh0uMaQXX4L0n6aSBRrVZu-6FPFe88lE-j8uGu0z7dgwHRvi0MElcWGYKg_DEP")
        MapplsAccountManager.setClientSecret("lrFxI-iSEg-hoKuzT6KXw14ERlRgVryeiOORbkVl2IMhovfVkgV2tdrxWAuxAlvxqQDNO6ZUNKTmd39UcAx1MHlg3AF6OXAEa4c-3vupaIY=")
        MapplsMapAuthenticator.sharedManager().initializeSDKSession { isSucess, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

