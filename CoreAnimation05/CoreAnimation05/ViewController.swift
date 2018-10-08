//
//  ViewController.swift
//  CoreAnimation05
//
//  Created by roni on 2018/9/26.
//  Copyright © 2018年 roni. All rights reserved.
//

import UIKit

class FaceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.center  = center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var textColor: UIColor = .red {
        didSet {
            label.textColor = textColor
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
}

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!

    lazy var faces: [FaceView] = {
        var array = [FaceView]()
        for i in 0...5 {
            let view = FaceView()
            view.textColor = UIColor(red: CGFloat(50 * i) / 255.0, green: CGFloat(61 * i) / 255.0, blue: CGFloat(72 * i) / 255.0, alpha: 1)
            view.label.text = String(describing: i + 1)
            array.append(view)
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        redView01.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        redView01.center = view.center
//        view.addSubview(redView01)

//        let maskLyer = CALayer()
//        maskLyer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        maskLyer.backgroundColor = UIColor.black.cgColor
//        redView01.layer.mask = maskLyer

//        affineAction()

//        transform3DAction()

//        // 灭点
//        var perspective = CATransform3DIdentity
//        perspective.m34 = -1.0 / 500.0
//
//        containerView.layer.sublayerTransform = perspective

//        let transform01 = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 1, 0)
//        leftImageView.layer.transform = transform01
//
//        let transform02 = CATransform3DMakeRotation(-CGFloat.pi / 4, 0, 1, 0)
//        rightImageView.layer.transform = transform02

//        let transform01 = CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0)
//        leftImageView.layer.transform = transform01
//
//        let transform02 = CATransform3DMakeRotation(-CGFloat.pi, 0, 1, 0)
//        rightImageView.layer.transform = transform02
//
//        // 背面是否绘制
//        leftImageView.layer.isDoubleSided = false

        containerView.backgroundColor = .gray
//        var outer = CATransform3DIdentity
//        outer.m34 = -1.0 / 500.0
//        outer = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 1, 0)
//        containerView.layer.transform = outer
//
//        var inner = CATransform3DIdentity
//        inner.m34 = -1.0 / 500.0
//        inner = CATransform3DMakeRotation(-CGFloat.pi / 4, 0, 1, 0)
//        leftImageView.layer.transform = inner

        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        perspective = CATransform3DRotate(perspective, -CGFloat.pi / 4, 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -CGFloat.pi / 4, 0, 1, 0)

        containerView.layer.sublayerTransform = perspective

        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(index: 0, with: transform)

        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 2, 0, 1, 0)
        addFace(index: 1, with: transform)

        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 2, 1, 0, 0)
        addFace(index: 2, with: transform)

        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, -CGFloat.pi / 2, 1, 0, 0)
        addFace(index: 3, with: transform)

        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -CGFloat.pi / 2, 0, 1, 0)
        addFace(index: 4, with: transform)

        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, CGFloat.pi, 0, 1, 0)
        addFace(index: 5, with: transform)

//        perspective = CATransform3DRotate(perspective, -CGFloat.pi / 4, 1, 0, 0)
//        perspective = CATransform3DRotate(perspective, -CGFloat.pi / 4, 0, 1, 0)
//        containerView.layer.transform = perspective
    }

    func addFace(index: Int, with transform: CATransform3D) {
        guard index < faces.count else {
            return
        }
        let face = faces[index]
        containerView.addSubview(face)

        let size = containerView.bounds.size

        face.label.frame = CGRect(x: (size.width - 200) / 2, y: (size.height - 200) / 2, width: 50, height: 50)

        face.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        face.center = CGPoint(x: size.width / 2.0, y: size.height / 2)
        face.layer.transform = transform
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

