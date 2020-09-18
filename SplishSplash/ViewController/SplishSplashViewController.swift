//
//  ViewController.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SplishSplashViewController: UIViewController {
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(tapGesture)
    }
    //MARK:- Tap Gesture method
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        // I created a method that will determine where the splish and splashes would generate based on the location of the tap gesture
        splishSplashAnimation(location: self.tapGesture.location(in: view))
    }
    //MARK:- Splish and Splashes Animations
    private func splishSplashAnimation(location: CGPoint) {
        // Splishes
        let randomSize = CGFloat.random(in: 60...150)
        let color = view.randomColor()
        view.splishSplashAnimation(location: location, size: randomSize, color: color, delay: 0)
        
        let splashCount = Int.random(in: 2...5)
        // Splashes
        for _ in 0..<splashCount {
            let distance = CGFloat.random(in: 60...100)
            let angle = CGFloat.random(in: 0..<2 * CGFloat.pi)
            let newLocation = CGPoint(x: (location.x + (distance * sin(angle))), y: (location.y + (distance * cos(angle))))
            let size = CGFloat.random(in: 0.2...0.4) * randomSize
            view.splishSplashAnimation(location: newLocation, size: size, color: color, delay: 0.15)
        }
    }
}

