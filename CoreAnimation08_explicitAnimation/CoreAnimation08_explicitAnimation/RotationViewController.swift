//
//  RotationViewController.swift
//  CoreAnimation08_explicitAnimation
//
//  Created by roni on 2018/11/14.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    let shipLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shipLayer.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        shipLayer.position = CGPoint(x: 150, y: 150)
        shipLayer.contents = UIImage(named: "feiji")?.cgImage
        containerView.layer.addSublayer(shipLayer)
    }

    @IBAction func rotation(_ sender: Any) {
        let animation = CABasicAnimation()
        // 虚拟属性
        animation.keyPath = "transform.rotation"
        animation.duration = 2.0
        animation.byValue = Double.pi * 2
        shipLayer.add(animation, forKey: nil)
    }
}
