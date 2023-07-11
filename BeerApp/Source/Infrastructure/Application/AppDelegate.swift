//
//  AppDelegate.swift
//  BeerApp
//
//  Created by Михаил Герман on 14.04.2023.
//

import UIKit
import SwiftyBeaver

let logger = SwiftyBeaver.self

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLogging()
        return true
    }
    func setupLogging() {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        logger.addDestination(console)
    } 
}
