//
//  KeyFrameViewController.swift
//  CoreAnimation08_explicitAnimation
//
//  Created by roni on 2018/11/14.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class KeyFrameViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    let bezierPath = UIBezierPath()
    let shipLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()


        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        let shaperLayer = CAShapeLayer()
        shaperLayer.path = bezierPath.cgPath
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.strokeColor = UIColor.red.cgColor
        shaperLayer.lineWidth = 3.0
        containerView.layer.addSublayer(shaperLayer)

        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: 0, y: 150)
        shipLayer.contents = UIImage(named: "feiji")?.cgImage
        containerView.layer.addSublayer(shipLayer)
    }

    @IBAction func fly(_ sender: Any) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 4.0
        animation.path = bezierPath.cgPath
        animation.rotationMode = CAAnimationRotationMode.rotateAuto
        animation.delegate = self
        shipLayer.add(animation, forKey: nil)
    }
}

extension KeyFrameViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shipLayer.position = CGPoint(x: 300, y: 150)
        CATransaction.commit()
    }
}
