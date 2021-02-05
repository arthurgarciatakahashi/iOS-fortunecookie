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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let httpClient = makeAlamofireAdapter()
        let authentication = makeRemoteAuthentication(httpClient: httpClient)
        let loginController = makeLoginController(authentication: authentication)
        //let getCookie = makeRemoteGetCookie(httpClient: httpClient)
        //let signUpController = makeSignUpController(getCookie: getCookie)
        let nav = NavigationController(rootViewController: loginController )

        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

