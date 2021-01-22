//
//  SceneDelegate.swift
//  Main
//
//  Created by arthur takahashi on 19/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let httpClient = makeAlamofireAdapter()
        let getCookie = makeRemoteGetCookie(httpClient: httpClient)
        window?.rootViewController = makeSignUpController(getCookie: getCookie)
        window?.makeKeyAndVisible()
    }
}

