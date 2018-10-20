//
//  AppDelegate.swift
//  DateShare
//
//  Created by Imajin Kawabe on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let APIKey = "AIzaSyCmuTKZ8WB0yENEQDkpjIERlZTvvKs6SfU"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey(APIKey)
        GMSPlacesClient.provideAPIKey(APIKey)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

