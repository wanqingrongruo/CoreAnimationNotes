//
//  ReplicatorLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/10.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class ReflectionView: UIView {
    override open class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }

    var reflectionGap: CGFloat = 0
    var reflectionScale: CGFloat = 0
    var reflectionAlpha: CGFloat = 0

    var imageView: UIImageView?
    var gradientLayer: CAGradientLayer?

    func setup() {
        reflectionGap = 4.0
        reflectionScale = 0.5
        reflectionAlpha = 0.5

        setNeedsLayout()
    }

    // 不起作用
    func update() {

        imageView?.removeFromSuperview()
        imageView = nil

        imageView = UIImageView(image: UIImage(named: "image06"))
        imageView?.frame = bounds
        if let im = imageView {
            addSubview(im)
        }

        let layer = self.layer as! CAReplicatorLayer
        layer.instanceCount = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

        var transform = CATransform3DIdentity
        let verticalOffset = self.bounds.size.height + reflectionGap
        transform = CATransform3DTranslate(transform, 0, verticalOffset, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        layer.instanceTransform = transform
        layer.instanceAlphaOffset = Float(reflectionAlpha - 1.0)


        gradientLayer = CAGradientLayer()
        self.layer.mask = gradientLayer
        gradientLayer?.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.purple.cgColor]

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer?.frame = self.bounds
        gradientLayer?.locations = [NSNumber(value: 0.0), NSNumber(value: 0.1), NSNumber(value: 0.4), NSNumber(value: 0.7)]
//        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        CATransaction.commit()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        self.setup()
    }

    override func layoutSubviews() {
        update()
        super.layoutSubviews()
    }
}

class ReplicatorLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()
        
        repeatingLayer()

//        reflectAction()
    }

    func reflectAction() {
        let reflectionView = ReflectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        reflectionView.center = view.center
        containerView.addSubview(reflectionView)
    }

    func repeatingLayer() {
        let repeatingLayer = CAReplicatorLayer()
        repeatingLayer.frame = containerView.bounds
        containerView.layer.addSublayer(repeatingLayer)

        repeatingLayer.instanceCount = 10
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 50, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 5, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -50, 0)
        repeatingLayer.instanceTransform = transform

        repeatingLayer.instanceBlueOffset = -0.1
        repeatingLayer.instanceGreenOffset = -0.1

        // repeatingLayer 会绘制一个或多个图层的子图层, 当前就是绘制 layer
        let layer = CALayer()
        layer.frame = CGRect(x: 100, y: 50, width: 50, height: 50)
        layer.backgroundColor = UIColor.white.cgColor
        // 子图层
        repeatingLayer.addSublayer(layer)
    }

}
