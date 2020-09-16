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
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        //splish and splash methods
        splishAnimation()
    }
    
    private func splishAnimation() {
        //1. appears where user taps
        //2. animation options = .eastOut
        //3. radius scales from 0 to between 60 - 150 pixels
        //4. animation duration = 0.2
        //5. delay = 1.5
        //6. fadesOut in 0.5 seconds
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            self.splishView.splish.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.splishView.splish.alpha = 0.8
            let location = self.tapGesture.location(in: self.splishView)
            self.splishView.splish.frame.origin = CGPoint(x: location.x, y: location.y)
        })
        { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                self.splishView.splish.alpha = 0
            })
            { (done) in
                self.splishView.splish.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    private func splashAnimation() {
        
    }
    
}

