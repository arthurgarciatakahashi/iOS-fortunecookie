//
//  Storyboarded.swift
//  UI
//
//  Created by arthur takahashi on 19/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static func instanciate() -> Self
}

extension Storyboarded where Self: UIViewController{
    public static func instanciate() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0] //split by 'ViewController' word
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        return sb.instantiateViewController(identifier: vcName) as! Self
    }
}
