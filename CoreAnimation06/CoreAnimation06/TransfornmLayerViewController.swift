//
//  TransfornmLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/10.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class TransfornmLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()
        
        var pt = CATransform3DIdentity
        pt.m34 = -1 / 500.0

        containerView.layer.sublayerTransform = pt

        var ct01 = CATransform3DIdentity
        ct01 = CATransform3DTranslate(ct01, -100, 0, 0)
        let cube01 = cube(withTransform: ct01)
        containerView.layer.addSublayer(cube01)

        var ct02 = CATransform3DIdentity
        ct02 = CATransform3DTranslate(ct02, 100, 0, 0)
        ct02 = CATransform3DRotate(ct02, -CGFloat.pi / 4, 1, 0, 0)
        ct02 = CATransform3DRotate(ct02, -CGFloat.pi / 4, 0, 1, 0)
        let cube02 = cube(withTransform: ct02)
        containerView.layer.addSublayer(cube02)
    }
    

    func face(with transform: CATransform3D) -> CALayer {
        let face = CALayer()
        face.frame = CGRect(x: -50, y: -50, width: 100, height: 100)
        let red = CGFloat.random(in: 0 ... 1)
        let green = CGFloat.random(in: 0 ... 1)
        let blue = CGFloat.random(in: 0 ... 1)
        face.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1).cgColor

        face.transform = transform
        return face
    }

    func cube(withTransform: CATransform3D) -> CALayer {
        let cube = CATransformLayer()

        var transform = CATransform3DMakeTranslation(0, 0, 50)
        cube.addSublayer(face(with: transform))

        transform = CATransform3DMakeTranslation(50, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 2, 0, 1, 0)
        cube.addSublayer(face(with: transform))

        transform = CATransform3DMakeTranslation(0, -50, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 2, 1, 0, 0)
        cube.addSublayer(face(with: transform))

        transform = CATransform3DMakeTranslation(0, 50, 0)
        transform = CATransform3DRotate(transform, -CGFloat.pi / 2, 1, 0, 0)
        cube.addSublayer(face(with: transform))

        transform = CATransform3DMakeTranslation(-50, 0, 0)
        transform = CATransform3DRotate(transform, -CGFloat.pi / 2, 0, 1, 0)
        cube.addSublayer(face(with: transform))

        transform = CATransform3DMakeTranslation(0, 0, -50)
        transform = CATransform3DRotate(transform, CGFloat.pi, 0, 1, 0)
        cube.addSublayer(face(with: transform))

        let containerSize = containerView.bounds.size
        cube.position = CGPoint(x: containerSize.width / 2, y: containerSize.height / 2)
        cube.transform = withTransform

        return cube
    }

}
