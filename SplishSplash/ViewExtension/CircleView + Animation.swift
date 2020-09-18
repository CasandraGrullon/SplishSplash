//
//  SplishView.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

extension UIView {
    // I decided to add this method in a seperate file to make it easier to access this animation for any future features
    // The method parameters include location, color and a delay that can be manipulated when called for the splish and the splashes
    // I felt this was easier to maintain than creating two seperate functions for each of them
    public func circleAnimation(location: CGPoint, size: CGFloat, color: UIColor, delay: TimeInterval) {
        //1. everytime this method is called, a new circle will be added to the view
        let circle: UIView = {
            let splash = UIView(frame: CGRect(origin: location, size: CGSize(width: size, height: size)))
            splash.backgroundColor = color
            splash.layer.cornerRadius = size / 2
            return splash
        }()
        self.addSubview(circle)
        
        //2. This is how the circle will appear wherever the screen is tapped
        circle.center = location
        
        //3. First we transform the circle size to 0 so when we animate it later, it grows back to the instantiated size
        circle.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        //4. animate to scale and disappear 
        UIView.animate(withDuration: 0.2, delay: delay, options: [.curveEaseOut], animations: {
            circle.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
        { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveLinear], animations: {
                circle.alpha = 0
            }) { (done) in
                //5. once the initial animations are complete, remove from the Superview
                circle.removeFromSuperview()
            }
        }
    }
}
