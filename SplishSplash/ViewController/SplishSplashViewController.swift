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
    
    private var numberOfTaps = 0
    private var count = 0
    
    private var splishSize = CGFloat()
    private var splashSize = CGFloat()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        
        let splashes = Array(0..<randomCount).map { number -> UIImageView in
            let location = self.tapGesture.location(in: self.view)
            let splash = UIImageView(frame: CGRect(origin: location, size: CGSize(width: 100, height: 100)))
            //splash.center = CGPoint(x: location.x * CGFloat(randomValue(low: 6, high: 10)), y: location.y * CGFloat(randomValue(low: 6, high: 10)))
            splash.layer.cornerRadius = 50
            splash.alpha = 0
            self.view.addSubview(splash)
            return splash
        }
        count = splashes.count
        return splashes
    }
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        //splish and splash methods
        numberOfTaps += 1
        animate(location: self.tapGesture.location(in: view))
        //let splishes = createSplishes()
        //splishAnimation(splishes: splishes)
    }
    //MARK:- Splish Animation
    private func animate(location: CGPoint) {
        let randomSize = CGFloat.random(in: 60...150)
        let color = randomColor()
        circleAnimation(location: location, size: randomSize, color: color, delay: 0)
        
        for _ in 0..<3 {
            let distance = CGFloat.random(in: 60...100)
            let angle = CGFloat.random(in: 0..<2 * CGFloat.pi)
            let newLocation = CGPoint(x: (location.x + (distance * sin(angle))), y: (location.y + (distance * cos(angle))))
            let size = CGFloat.random(in: 0.2...0.4) * randomSize
            circleAnimation(location: newLocation, size: size, color: color, delay: 0.15)
        }
    }
    private func circleAnimation(location: CGPoint, size: CGFloat, color: UIColor, delay: TimeInterval) {
        let splash: UIView = {
           let splash = UIView(frame: CGRect(origin: location, size: CGSize(width: size, height: size)))
            splash.backgroundColor = color
            splash.layer.cornerRadius = size / 2
            
            return splash
        }()
        view.addSubview(splash)
        splash.center = location
        
        splash.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.2, delay: delay, options: [.curveEaseOut], animations: {
            splash.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveLinear], animations: {
                splash.alpha = 0
            }) { (done) in
                splash.removeFromSuperview()
            }
        }
    }
    
//    private func splishAnimation(splishes: [UIImageView]) {
//        let location = self.tapGesture.location(in: self.view)
//        //let endpoint = CGPoint(x: location.x * self.randomValue(low: 6, high: 10), y: location.y * self.randomValue(low: 6, high: 10))
//        UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
//            let size = self.randomValue(low: 6, high: 15)
//            self.splishSize = size
//
//            for splish in splishes {
//                splish.alpha = 0.8
//                splish.backgroundColor = self.randomColor()
//                splish.transform = CGAffineTransform(scaleX: size, y: size)
//
//                self.splashAnimation(splish: splish, index: self.count, endpoint: location) {
//
//                }
//            }
//        })
//        { (done) in
//            UIView.animate(withDuration: 0.2, delay: 0.15, options: [.curveEaseOut], animations: {
//                for splish in splishes {
//                    splish.alpha = 0
//                }
//            })
//        }
//    }
//    //MARK:- Splash Animation
//    private func splashAnimation(splish: UIImageView, index: Int, endpoint: CGPoint,  completion: @escaping () -> ()) {
//        var splashes = createSplashes()
//        let randomSize = self.randomValue(low: 2, high: 4)
//
//        guard splashes.indices.contains(index) else {
//            completion()
//            return
//        }
//
//        let x = endpoint.x * self.randomValue(low: 6, high: 10)
//        let y = endpoint.y * self.randomValue(low: 6, high: 10)
//        splashes[index].center = CGPoint(x: x, y: y)
//
//        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
//            splashes[index].backgroundColor = splish.backgroundColor
//            splashes[index].transform = CGAffineTransform(scaleX: randomSize, y: randomSize)
//            splashes[index].alpha = 0.8
//        })
//            { (done) in
//                splashes[index].alpha = 0
//                self.count -= 1
//                splashes.remove(at: index)
//                 self.splashAnimation(splish: splish, index: index + 1, endpoint: endpoint, completion: completion)
//            }
//    }
    //MARK:- Random Value Generators
    private func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.8)
    }
    private func randomValue(low: Int, high: Int) -> CGFloat {
        let values = Array(low...high)
        return CGFloat(values.randomElement() ?? 6) * 0.1
    }
    private func randomUnit() -> CGFloat {
        return CGFloat(([1, -1].randomElement() ?? 1) * 0.1)
    }
}

