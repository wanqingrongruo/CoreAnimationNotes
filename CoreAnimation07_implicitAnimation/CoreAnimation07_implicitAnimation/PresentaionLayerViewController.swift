//
//  PresentaionLayerViewController.swift
//  CoreAnimation07_implicitAnimation
//
//  Created by roni on 2018/11/13.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class PresentaionLayerViewController: UIViewController {

    let colorLayer: CALayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        colorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        colorLayer.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        view.layer.addSublayer(colorLayer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else { return }
        if let presentationLayer = colorLayer.presentation(), presentationLayer.hitTest(point) != nil {
            let red = CGFloat.random(in: 0 ... 1)
            let green = CGFloat.random(in: 0 ... 1)
            let blue = CGFloat.random(in: 0 ... 1)
            colorLayer.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1).cgColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2.0)
            colorLayer.position = point
            CATransaction.commit()
        }
    }
}
