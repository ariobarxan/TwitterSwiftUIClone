//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/23/22.
//

import SwiftUI
import Firebase

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}
@main
struct TwitterCloneApp: App {
    // register app delegate for Firebase setup
    //  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
               ContentView()
                    .environmentObject(SignInViewModel())
            }
            
        }
    }
}

//Bugfix navigationview title should be explixitly noted based on the tab in the main tab view
