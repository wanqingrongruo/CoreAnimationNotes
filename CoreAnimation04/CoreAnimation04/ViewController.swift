//
//  ViewController.swift
//  CoreAnimation04
//
//  Created by roni on 2018/7/9.
//  Copyright © 2018年 roni. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    private lazy var whiteView01: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var whiteView02: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var redView01: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private lazy var redView02: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .gray
        let shadowView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        view.addSubview(shadowView)

        whiteView01.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        whiteView02.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        redView01.frame = CGRect(x: -25, y: -25, width: 50, height: 50)
        redView02.frame = CGRect(x: -25, y: -25, width: 50, height: 50)

        view.addSubview(whiteView01)
        shadowView.addSubview(whiteView02)
        whiteView01.addSubview(redView01)
        whiteView02.addSubview(redView02)

        whiteView01.layer.cornerRadius = 20
        whiteView02.layer.cornerRadius = 20

        whiteView02.layer.masksToBounds = true

        whiteView01.layer.borderWidth = 5
        whiteView02.layer.borderWidth = 5

        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        shadowView.layer.shadowRadius = 5

        // masksToBounds 与 shadow 是有冲突的, 会剪裁掉阴影, 因为阴影在边界之外
        // 解决: 用父视图将他(需要剪裁的 view)包裹起来,设置父视图(shadowView)的阴影


        // 通过 shadowPath 指定阴影形状来提高性能
//        let squarePath = CGMutablePath()
//        squarePath.addEllipse(in: shadowView.bounds)
//        shadowView.layer.shadowPath = squarePath
        // 简单的圆/矩形通过 CGPath 绘制, 复杂的可以使用 UIBezierPath

        let size = shadowView.bounds.size
        let width = size.width
        let height = size.height
        let depth = CGFloat(11.0)
        let lessDepth = 0.8 * depth
        let curvyness = CGFloat(5)
        let radius = CGFloat(1)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: height))
        path.addLine(to: CGPoint(x:width - 2 * radius,y:height))
        path.addLine(to: CGPoint(x: width - 2*radius, y: height + depth))
        path.addCurve(to: CGPoint(x: radius, y: height + depth), controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness), controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
        shadowView.layer.shadowPath = path.cgPath

        // notice: 设置了 shadowPath 的同时也要设置 shadowRadius 等属性才能起作用
    }

}

