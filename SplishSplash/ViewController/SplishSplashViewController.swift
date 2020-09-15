//
//  ViewController.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SplishSplashViewController: UIViewController {
    
    @IBOutlet weak var splishView: UIView!
    
    private var tapped = false {
        didSet {
            
        }
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(tapGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
            self.splishView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.splishView.alpha = 0.8
        }) { (done) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseOut], animations: {
                self.splishView.alpha = 0
            }) { (done) in
                self.splishView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
        }
    }
    private func splashAnimation() {
        
    }
    
}

