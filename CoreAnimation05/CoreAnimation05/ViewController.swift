//
//  ViewController.swift
//  CoreAnimation05
//
//  Created by roni on 2018/9/26.
//  Copyright © 2018年 roni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        redView01.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        redView01.center = view.center
        view.addSubview(redView01)

//        let maskLyer = CALayer()
//        maskLyer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        maskLyer.backgroundColor = UIColor.black.cgColor
//        redView01.layer.mask = maskLyer

//        affineAction()

        transform3DAction()

    }

    // 仿射变换 -- 2D  => Core Graphics
    private func affineAction() {
        // 旋转
        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)

        // 缩放
        let scaleTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        // 平移
        let translationTransform = CGAffineTransform(translationX: 50, y: 50)

        // 组合
        let concatTransform = rotationTransform.concatenating(scaleTransform).concatenating(translationTransform)

        UIView.animate(withDuration: 3, animations: {
            self.redView01.transform = concatTransform
        }) { (isFinished) in
            if isFinished {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.redView01.transform = CGAffineTransform.identity
                }
            }
        }
    }

    // 3D  => Core Animation
    private func transform3DAction() {
        // 绕 y 轴 转 45°
        var rotationTransform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 1, 0)

        // 投影变换 => 透视效果
        rotationTransform.m34 = -1 / 500.0

        self.redView01.layer.transform = rotationTransform
    }

    private lazy var redView01: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

}

