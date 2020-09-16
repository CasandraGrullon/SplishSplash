//
//  ViewController.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SplishSplashViewController: UIViewController {
    
    private var splishView = SplishView()
    
    override func loadView() {
        view = splishView
        splishView.backgroundColor = .systemBackground
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        splishView.splish.alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(tapGesture)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        splishStartState()
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        //splish and splash methods
        splishAnimation()
        splashAnimation()
    }
    
    private func splishAnimation() {
        //1. appears where user taps
        //2. animation options = .eastOut
        //3. radius scales from 0 to between 60 - 150 pixels
        //4. animation duration = 0.2
        //5. delay = 1.5
        //6. fadesOut in 0.5 seconds
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            //random color
            self.splishView.splish.backgroundColor = self.randomColor()
            
            //present where user tapped
            let location = self.tapGesture.location(in: self.splishView)
            self.splishView.splish.center = location
            
            //scale up
            self.splishView.splish.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            
            //change alpha
            self.splishView.splish.alpha = 0.8
        })
        { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                self.splishView.splish.alpha = 0
            })
        }
    }
    func splishStartState() {
        UIView.animate(withDuration: 0) {
            self.splishView.splish.center = self.view.center
            self.splishView.splish.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    private func splashAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
            //random color
            self.splishView.splash.backgroundColor = self.randomColor()
            
            //present where user tapped
            let location = self.splishView.splish.center
            self.splishView.splash.center.x = location.x * 0.5
            self.splishView.splash.center.y = location.y
            
            //scale up
            self.splishView.splash.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            
            //change alpha
            self.splishView.splash.alpha = 0.8
        }) { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                self.splishView.splash.alpha = 0
            })
        }
    }
    private func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

