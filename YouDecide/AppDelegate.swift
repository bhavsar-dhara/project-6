//
//  AppDelegate.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-16.
//

import UIKit
import CoreData
import GooglePlaces

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataController = DataController(modelName: "YouDecide")
    
    var arrPlaces : [PlaceInfo] = []
    var arrTravelData: [NSManagedObject] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        dataController.load()
        
        let navigationController = window?.rootViewController as! UINavigationController
        let splashView = navigationController.topViewController as! SplashViewController
        splashView.dataController = (UIApplication.shared.delegate as? AppDelegate)?.dataController
        GMSPlacesClient.provideAPIKey("AIzaSyBNLRM1ncgW-Veo9luICk0B8w913FvF-TU")
        
        return true
    }
}

