//
//  AppDelegate.swift
//  Bankey-Swift
//
//  Created by hakkı can şengönül on 18.08.2022.
//

import UIKit
let appColor: UIColor = .systemTeal
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        registerForNotifications()
        let vc = MainViewController()
        vc.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        UINavigationBar.appearance().barStyle = .black
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
    private func registerForNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    @objc func didLogout(){
        setRootViewController(loginViewController)
    }
    
}

extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(onboardingContainerViewController)
        }else{
            setRootViewController(onboardingContainerViewController)
        }
    }
}
extension AppDelegate: OnboardingContainerViewControllerDelegate{
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(loginViewController)
    }
}
extension AppDelegate{
    func setRootViewController(_ vc: UIViewController, animated: Bool = true){
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        UIView.transition(with: window!, duration: 0.4, options: .transitionCrossDissolve, animations: nil)
    }
}
