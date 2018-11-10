//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit

import SwiduxTasksExample
import SwiduxRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window.rootViewController =  Router(
            store: store,
            keyPath: \.routes
        )
        window.makeKeyAndVisible()

        return true
    }
}
