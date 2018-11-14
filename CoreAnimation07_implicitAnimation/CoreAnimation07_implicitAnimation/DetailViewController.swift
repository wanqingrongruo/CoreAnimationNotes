//
//  DetailViewController.swift
//  CoreAnimation07_implicitAnimation
//
//  Created by roni on 2018/11/13.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tag = 0

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var redView: UIView!

    let colorLayer: CALayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        tag = 1
        /*
        // UIView 禁用隐式动画的方法
       // 每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值

        let outsideDelegate = redView.action(for: redView.layer, forKey: "backgroundColor")
        print("outSide: \(String(describing: outsideDelegate))") // null
        UIView.beginAnimations(nil, context: nil)
        let insideDelegate = redView.action(for: redView.layer, forKey: "backgroundColor")
        print("inSide: \(String(describing: insideDelegate))")
        UIView.commitAnimations()
    */

        colorLayer.frame = CGRect(x: 0, y: 0, width: redView.bounds.width, height: redView.bounds.height)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        redView.layer.addSublayer(colorLayer)

        let transition = CATransition()
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromLeft
        colorLayer.actions = ["backgroundColor": transition]

        // 呈现图层:模型图层的复制, 它的属性值代表了在任何指定时刻当前外观效果
        colorLayer.presentation()//?.model()
    }

    @IBAction func changeColor(_ sender: UIButton) {
        let red = CGFloat.random(in: 0 ... 1)
        let green = CGFloat.random(in: 0 ... 1)
        let blue = CGFloat.random(in: 0 ... 1)
        colorLayer.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1).cgColor
    }

    var callback: ((_ tag: Int) -> Void)?

}
