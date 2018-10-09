//
//  ShapeLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/9.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class ShapeLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()
        
        createShapeLayer()

        drawCorner()
    }

    override func handleOrientation() {
        let width = UIScreen.main.bounds.width
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: 300)
        containerView.center = view.center

        containerView.layer.sublayers?.forEach({
            $0.removeFromSuperlayer()
        })

        createShapeLayer()

        drawCorner()
    }

    func createShapeLayer() {
        // path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))

        // shape
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor // 边框色
        shapeLayer.fillColor = UIColor.clear.cgColor // 填充色
        shapeLayer.lineWidth = 5
        shapeLayer.lineCap = .round // 线条结尾的样子
        shapeLayer.lineJoin = .round // 结合点的样子
        shapeLayer.path = path.cgPath

        containerView.layer.addSublayer(shapeLayer)

    }

    func drawCorner() {
        // 本质是绘制了一个蒙层, 蒙层实心以外的看不见
        let radii = CGSize(width: 20, height: 20)
        let corners: UIRectCorner  = [UIRectCorner.topLeft, UIRectCorner.topRight]
        let path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: corners, cornerRadii: radii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = containerView.bounds
        shapeLayer.path = path.cgPath
        containerView.layer.mask = shapeLayer
    }

}
