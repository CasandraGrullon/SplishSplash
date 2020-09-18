//
//  RandomColor.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

extension UIView {
    // Once again, I placed this method in a seperate file on the chance future app features would need to access it
    public func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.8)
    }
}
