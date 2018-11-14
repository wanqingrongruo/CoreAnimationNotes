//
//  ViewController.swift
//  CoreAnimation07_implicitAnimation
//
//  Created by roni on 2018/10/17.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var redView: UIView!
    let colorLayer: CALayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
//        colorLayer.frame = CGRect(x: 0, y: 0, width: redView.bounds.width, height: redView.bounds.height)
//        colorLayer.backgroundColor = UIColor.blue.cgColor
//        redView.layer.addSublayer(colorLayer)

        redView.layer.backgroundColor = UIColor.blue.cgColor
    }

    @IBAction func changeColor(_ sender: UIButton) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2.0)
//        CATransaction.setCompletionBlock { [weak self] in
//            guard let `self` = self  else { return }
//            var transform = self.colorLayer.affineTransform()
//            transform = transform.rotated(by: CGFloat.pi / 2)
//            self.colorLayer.setAffineTransform(transform)
//        }
        let red = CGFloat.random(in: 0 ... 1)
        let green = CGFloat.random(in: 0 ... 1)
        let blue = CGFloat.random(in: 0 ... 1)
       // colorLayer.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1).cgColor
        redView.layer.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1).cgColor
        CATransaction.commit()
    }

    @IBAction func skipToNextPage(_ sender: Any) {
        performSegue(withIdentifier: "goto_detail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.callback = { tag in
                print("======\(tag)======")
            }
        }
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if let vc = segue.source as? DetailViewController {
            vc.callback?(vc.tag)
        }
    }

    @IBAction func unwindPresentation(segue: UIStoryboardSegue) {
        
    }
}

