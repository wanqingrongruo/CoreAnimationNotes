//
//  ViewController.swift
//  CoreAnimation01
//
//  Created by roni on 2018/6/5.
//  Copyright © 2018年 roni. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        centerView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        centerView.center = view.center
        view.addSubview(centerView)

        centerView.contentMode = .scaleAspectFill

        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        blueLayer.delegate = self
        centerView.layer.contentsScale = UIScreen.main.scale
        centerView.layer.addSublayer(blueLayer)
//        // contents: 对应 cgImage 值 --- 寄宿图
//        let image = UIImage(named: "other")
//        centerView.layer.contents = image?.cgImage
//        // 对应 contentMode
////        centerView.layer.contentsGravity = "resizeAspect"
//
//        // 一个点用几个像素去显示
//        // 当用代码的方式处理寄宿图时, 一定要记住手动的设置图层的 contentsScale 属性
////        centerView.layer.contentsScale = UIScreen.main.scale
////        centerView.layer.masksToBounds = true
//
//        // contentsRect: 寄宿图的子域, (0,0,1,1) 的矩形
////        centerView.layer.contentsRect = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5)
//
//        //  --- 没懂
//        centerView.layer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5)
        blueLayer.display()
    }

    func setContentRect(rect: CGRect) {
        let image = UIImage(named: "other")
        centerView.layer.contents = image?.cgImage
        // 对应 contentMode
        centerView.layer.contentsGravity = "resizeAspect"

        // 一个点用几个像素去显示
        // 当用代码的方式处理寄宿图时, 一定要记住手动的设置图层的 contentsScale 属性
        centerView.layer.contentsScale = UIScreen.main.scale
        centerView.layer.masksToBounds = true

        // contentsRect: 寄宿图的子域, (0,0,1,1) 的矩形
        centerView.layer.contentsRect = rect//CGRect(x: 0.5, y: 0.5, width: 1, height: 1)
    }
}

extension ViewController: CALayerDelegate {
    // func display(_ layer: CALayer) 未实现即调用当前代理方法
    // 调用这个方法前 CALayer 创建了一个合适尺寸的空寄宿图(尺寸由 bounds and contentScale 决定) 和 一个 Core Graphics 的绘制上下文的环境,为绘制寄宿图做准备
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(10.0)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokeEllipse(in: layer.bounds)
    }
}

