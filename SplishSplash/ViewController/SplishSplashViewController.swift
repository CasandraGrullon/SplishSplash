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
    private var splashSize = CGFloat()
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
    private func createSplishes() -> [UIImageView] {
        splishSize = view.frame.width * 0.6
        splashSize = (view.frame.width * 0.6) / 2
        
        let splishes = Array(0...numberOfTaps).map { number -> UIImageView in
            let location = self.tapGesture.location(in: self.view)
            let splish = UIImageView(frame: CGRect(origin: location, size: CGSize(width: splishSize, height: splishSize)))
            splish.center = location
            splish.layer.cornerRadius = splishSize / 2
            self.view.addSubview(splish)
            return splish
        }
        
        return splishes
    }
    private func createSplashes() -> [UIImageView] {
        let randomCount = Array(2...5).randomElement() ?? 2
        let randomPoint = CGFloat(Array(6...10).randomElement() ?? 2)
        
        let splashes = Array(0..<randomCount).map { number -> UIImageView in
            let location = self.tapGesture.location(in: self.view)
            let splash = UIImageView(frame: CGRect(origin: location, size: CGSize(width: splashSize, height: splashSize)))
            splash.center = CGPoint(x: location.x * CGFloat(randomPoint) * 0.1, y: location.y)//CGPoint(x: location.x * CGFloat(randomPoint.randomElement() ?? 6) * 0.1, y: location.y * CGFloat(randomPoint.randomElement() ?? 6) * 0.1 )
            splash.layer.cornerRadius = splashSize / 2
            self.view.addSubview(splash)
            return splash
        }
        return splashes
    }
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        //splish and splash methods
        numberOfTaps += 1
        let splishes = createSplishes()
        splishAnimation(splishes: splishes)
        
        let splashes = createSplashes()
        for splash in splashes {
            splashAnimation(splishes: splishes, splash: splash)
        }
    }
    //MARK:- Splish Animation
    private func splishAnimation(splishes: [UIImageView]) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            let size = self.randomValue(low: 6, high: 15)
            self.splishSize = size
            
            for splish in splishes {
                splish.alpha = 0.8
                splish.backgroundColor = self.randomColor()
                splish.transform = CGAffineTransform(scaleX: size, y: size)
            }
        })
        { (done) in
            UIView.animate(withDuration: 0.2, delay: 1.5, options: [.layoutSubviews,.curveEaseOut], animations: {
                for splish in splishes {
                    splish.alpha = 0
                    let splashes = self.createSplashes()
                    for splash in splashes {
                        self.splashAnimation(splishes: splishes, splash: splash)
                    }
                }
            })
        }
    }
    //MARK:- Splash Animation
    private func splashAnimation(splishes: [UIImageView], splash: UIImageView) {
        UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
            let randomSize = self.randomValue(low: 2, high: 4)
            self.splashSize = (self.splishSize * randomSize)
            
            let randomPoint = CGFloat(Array(6...10).randomElement() ?? 2)
            
            for splish in splishes {
                splash.backgroundColor = splish.backgroundColor
                splash.bounds.origin.y = splish.bounds.origin.y * CGFloat(randomPoint * self.randomUnit())
                splash.bounds.origin.x = splish.bounds.origin.x * CGFloat(randomPoint * self.randomUnit())
                //splash.center = CGPoint(x: splish.center.x * (CGFloat(randomPoint) * 0.1), y: splish.center.y)
                splash.transform = CGAffineTransform(scaleX: self.splashSize, y: self.splashSize)
                splash.alpha = 0.8
            }
            
        }) { (done) in
            UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
                splash.alpha = 0
            })
        }
    }
    //MARK:- Random Value Generators
    private func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    private func randomValue(low: Int, high: Int) -> CGFloat {
        let values = Array(low...high)
        return CGFloat(values.randomElement() ?? 6) * 0.1
    }
    private func randomUnit() -> CGFloat {
        return CGFloat(([1, -1].randomElement() ?? 1) * 0.1)
    }
}

