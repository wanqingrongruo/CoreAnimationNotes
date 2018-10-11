//
//  main.swift
//  TiledLayerHelper
//
//  Created by roni on 2018/10/11.
//  Copyright © 2018 roni. All rights reserved.
//

import Foundation
import AppKit

print("Hello, World!")

func main() {
//    let argc = CommandLine.argc
//    if argc < 2 {
//        print("TileCutter arguments: InputFile")
//        return
//    }

    let inputFile = CommandLine.arguments[0]
    let tileSize: CGFloat = 256
    let outputPath = (inputFile as NSString).deletingPathExtension
    guard let image = NSImage(contentsOfFile: inputFile) else {
        return
    }
    var size = image.size
    let representations = image.representations
    if representations.count > 0 {
        let representation = representations[0]
        size.width = CGFloat(representation.pixelsWide)
        size.height = CGFloat(representation.pixelsHigh)
    }
    var rect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
    guard let imageRef = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) else {
        return
    }
    let rows = Int(ceil(size.height / tileSize))
    let cols = Int(ceil(size.width / tileSize))

    for i in 0..<rows {
        for j in 0..<cols{
            let titleRect = CGRect(x: CGFloat(i) * tileSize,
                                   y: CGFloat(j) * tileSize,
                                   width: tileSize,
                                   height: tileSize)
            guard let tileImage = imageRef.cropping(to: titleRect) else {
                return
            }
            let imageRep = NSBitmapImageRep(cgImage: tileImage)
            let data = imageRep.representation(using: .jpeg, properties: [:])
            let path = outputPath.appendingFormat("_%02d_%02d.jpeg", i, j)
            if let da = data {
                 _ = (da as NSData).write(toFile: path, atomically: false)
            }
        }
    }
}

main()
