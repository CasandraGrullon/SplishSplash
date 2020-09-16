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
    
    private var numberOfTaps = 0
    
    private var splishSize = CGFloat()
    private var viewSplishes = [UIImageView]()
    private var viewSplashes = [UIImageView]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        splishView.splish.alpha = 0
        splishView.splash.alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(tapGesture)
        
    }
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        //splish and splash methods
        numberOfTaps += 1
        let splishes = Array(0...numberOfTaps).map { number -> UIImageView in
            let splish = UIImageView(frame: CGRect(origin: view.center, size: CGSize(width: 100, height: 100)))
            splish.layer.cornerRadius = 50
            self.view.addSubview(splish)
            return splish
        }
        let random = Array(2...5).randomElement() ?? 2
        
        let splashes = Array(0...random).map { number -> UIImageView in
            let splish = UIImageView(frame: CGRect(origin: view.center, size: CGSize(width: 100, height: 100)))
            splish.layer.cornerRadius = 50
            self.view.addSubview(splish)
            return splish
        }
        viewSplishes = splishes
        viewSplashes = splashes
        splishAnimation(splishes: splishes)
        splashAnimation(splishes: splishes, splashes: splashes)
    }
    private func splishAnimation(splishes: [UIImageView]) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            let location = self.tapGesture.location(in: self.view)
            let size = self.splishScaleSize()
            self.splishSize = size

            for splish in splishes {
                splish.alpha = 0.8
                splish.backgroundColor = self.randomColor()
                splish.transform = CGAffineTransform(scaleX: size, y: size)
                splish.center = location
            }
        })
        { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                for splish in splishes {
                    splish.alpha = 0
                }
            })
        }
        
    }
    private func splashAnimation(splishes: [UIImageView], splashes: [UIImageView]) {
        UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
            for splish in splishes {
                for splash in splashes {
                    splash.backgroundColor = splish.backgroundColor
                    //present where user tapped
                    
                    //TODO: multiple splash views are dispersed randomly 60 - 100 pixels away from splish view center
                    let randomPoint = Array(6...15).randomElement() ?? 6
                    splash.center = CGPoint(x: splish.center.x * CGFloat(randomPoint) * 0.1, y: splish.center.y )
                    //splash.center.y = splish.center.y
                    
                    //scale down
                    splash.transform = CGAffineTransform(scaleX: self.splishSize * 0.4, y: self.splishSize * 0.4)
                    
                    //change alpha
                    splash.alpha = 0.8
                }
            }
        }) { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                for splash in splashes {
                    splash.alpha = 0
                }
            })
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
        return CGFloat(sizes.randomElement() ?? 6) * 0.1
    }
    private func generateSplashes() {
        
    }
}

