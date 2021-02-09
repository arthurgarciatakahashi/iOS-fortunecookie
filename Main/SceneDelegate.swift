//
//  SceneDelegate.swift
//  Main
//
//  Created by arthur takahashi on 19/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let signUpFactory: () -> SignUpViewController = {
        let alamoFireAdapter = makeAlamofireAdapter()
        let remoteGetCookie = makeRemoteGetCookie(httpClient: alamoFireAdapter)
        return makeSignUpController(getCookie: remoteGetCookie)
    }

    private let loginFactory: () -> LoginViewController = {
        let alamoFireAdapter = makeAlamofireAdapter()
        let remoteAuthentication = makeRemoteAuthentication(httpClient: alamoFireAdapter)
        return makeLoginController(authentication: remoteAuthentication)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
        let welcomeViewController = WelcomeViewController.instanciate()
        welcomeViewController.signUp = welcomeRouter.goToSignUp
        welcomeViewController.login = welcomeRouter.goToLogin
        nav.setRootViewController(welcomeViewController)

        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

