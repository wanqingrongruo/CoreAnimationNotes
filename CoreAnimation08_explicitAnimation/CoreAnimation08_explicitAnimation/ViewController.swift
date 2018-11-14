//
//  ViewController.swift
//  CoreAnimation08_explicitAnimation
//
//  Created by roni on 2018/11/14.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var layerView: UIView!
    let colorLayer: CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorLayer.frame = CGRect(x: 50, y: 0, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        layerView.layer.addSublayer(colorLayer)
    }

    @IBAction func changeColor(_ sender: Any) {
        let red = CGFloat.random(in: 0 ... 1)
        let green = CGFloat.random(in: 0 ... 1)
        let blue = CGFloat.random(in: 0 ... 1)
        let color = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
//        let animation = CABasicAnimation()
//        animation.keyPath = "backgroundColor"
//        animation.toValue = color.cgColor
//        animation.delegate = self
//        colorLayer.add(animation, forKey: nil)

        /* 在找不到代理实现是寻找 => actions => styles
        let transition = CATransition()
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromLeft
        colorLayer.actions = ["backgroundColor": transition]
         */

        // 关键帧动画
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [UIColor.blue.cgColor, UIColor.red.cgColor, color.cgColor, UIColor.blue.cgColor]
        colorLayer.add(animation, forKey: nil)
    }

    @IBAction func unwindPresentation(segue: UIStoryboardSegue) {

    }
    @IBAction func unwindRotation(segue: UIStoryboardSegue) {

    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        colorLayer.backgroundColor = ((anim as? CABasicAnimation)?.toValue as! CGColor)
        CATransaction.commit()
    }
}

