//
//  SplishView.swift
//  SplishSplash
//
//  Created by casandra grullon on 9/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SplishView: UIView {
    override func layoutSubviews() {
        splish.layer.cornerRadius = 50
    }
    public lazy var splish: UIImageView = {
        let imageView = UIImageView()
        var randomRed = CGFloat.random(in: 0...1)
        var randomBlue = CGFloat.random(in: 0...1)
        var randomGreen = CGFloat.random(in: 0...1)
        imageView.backgroundColor = UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.8)
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        splishConstraints()
    }
    private func splishConstraints() {
        addSubview(splish)
        splish.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            splish.widthAnchor.constraint(equalToConstant: 100),
            splish.heightAnchor.constraint(equalTo: splish.widthAnchor),
            splish.centerXAnchor.constraint(equalTo: centerXAnchor),
            splish.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
