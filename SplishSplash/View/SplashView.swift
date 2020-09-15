//
//  SplashView.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SplashView: UIView {

    private lazy var splashView: UIView = {
        let view = UIView()
        var randomValue = CGFloat.random(in: 0...1)
        view.backgroundColor = UIColor.init(red: randomValue, green: randomValue, blue: randomValue, alpha: 0.8)
        return view
    }()

}
