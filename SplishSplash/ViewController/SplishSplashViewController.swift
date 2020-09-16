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
    
    private var splishSize = CGFloat()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        splishView.splish.alpha = 0
        splishView.splash.alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(tapGesture)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        startState()
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        //splish and splash methods
        splishAnimation()
        splashAnimation()
    }
    
    private func splishAnimation() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            //random color
            self.splishView.splish.backgroundColor = self.randomColor()
            
            //present where user tapped
            //TODO: present multiple splish views for every tap
            let location = self.tapGesture.location(in: self.splishView)
            self.splishView.splish.center = location
            
            //scale up
            //TODO: splish view grows between 60 - 150 pixels bigger randomly
            let size = self.splishScaleSize()
            self.splishSize = size
            print(size)
            self.splishView.splish.transform = CGAffineTransform(scaleX: size, y: size)
            
            //change alpha
            self.splishView.splish.alpha = 0.8
        })
        { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                self.splishView.splish.alpha = 0
            })
        }
    }
    private func splashAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
            self.splishView.splash.backgroundColor = self.splishView.splish.backgroundColor
            
            //present where user tapped
            let location = self.splishView.splish.center
            //TODO: multiple splash views are dispersed randomly 60 - 100 pixels away from splish view center
            self.splishView.splash.center.x = location.x * 0.6
            self.splishView.splash.center.y = location.y * 1
            
            //scale down
            self.splishView.splash.transform = CGAffineTransform(scaleX: self.splishSize * 0.4, y: self.splishSize * 0.4)
            
            //change alpha
            self.splishView.splash.alpha = 0.8
        }) { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                self.splishView.splash.alpha = 0
            })
        }
    }
    func startState() {
        UIView.animate(withDuration: 0) {
            self.splishView.splish.transform = CGAffineTransform.identity
            self.splishView.splash.transform = CGAffineTransform.identity
        }
    }
    private func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    private func splishScaleSize() -> CGFloat {
        let sizes = Array(6...15)
        return CGFloat(sizes.randomElement() ?? 6) * 0.2
    }
}

