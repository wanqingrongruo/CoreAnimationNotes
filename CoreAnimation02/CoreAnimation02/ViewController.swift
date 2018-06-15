//
//  ViewController.swift
//  CoreAnimation02
//
//  Created by roni on 2018/6/11.
//  Copyright © 2018年 roni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var minView: UIView!
    @IBOutlet weak var secView: UIView!

    var timer: Timer!
    
    lazy var demoView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        // frame: 外部坐标, 在父图层上所占的空间
        // bounds: 内部坐标,
        demoView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

        // view'center is same as layer'position, represents the location relatived to the anchorPoint of parent layer
//        demoView.center = view.center
        demoView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        print(demoView.layer.position)

        // frame.origin.x = position.x - anchnorPoint.x * bounds.size.width
        // frame.origin.y = position.y - anchnorPoint.y * bounds.size.height
        // position and anchnorPoint 互不影响, 两个一起影响 frame.origin

        // position是layer中的anchorPoint在superLayer中的位置坐标
        // position 是相对 superLayer 来说, anchorPoint 是相对 layer 来说的, 两个是不同参照系下的重合点
        // 互不影响原则：单独修改position与anchorPoint中任何一个属性都不影响另一个属性

        view.addSubview(demoView)
 */
        bgView.layer.cornerRadius = 100
        hourView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        minView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        secView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)

        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

        tick()
    }

    @objc func tick() {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let componentSet: Set = [Calendar.Component.hour,
            Calendar.Component.minute, Calendar.Component.second]
        let components = calendar.dateComponents(componentSet, from: Date())

        let hourAngle = (CGFloat(components.hour ?? 0) / 12.0) * CGFloat.pi * 2.0
        let minsAngle = (CGFloat(components.minute ?? 0) / 60.0) * CGFloat.pi * 2.0
        let secsAngle = (CGFloat(components.second ?? 0) / 60.0) * CGFloat.pi * 2.0

        hourView.transform = CGAffineTransform(rotationAngle: hourAngle)
        minView.transform = CGAffineTransform(rotationAngle: minsAngle)
        secView.transform = CGAffineTransform(rotationAngle: secsAngle)
    }
}














