//
//  GradientLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/10.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class GradientLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()

        diagonalGradient()

        complexGradient()
    }

    func diagonalGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        containerView.layer.addSublayer(gradientLayer)

        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }

    func complexGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: (UIScreen.main.bounds.width - 150) / 2, y: 75, width: 150, height: 150)
        containerView.layer.addSublayer(gradientLayer)

        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.purple.cgColor]
        gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 0.1), NSNumber(value: 0.4), NSNumber(value: 0.7)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }

}
