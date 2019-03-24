//
//  Extensions.swift
//  FlagRecognizer
//
//  Created by Josip Rezic on 24/03/2019.
//  Copyright © 2019 Josip Rezic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public class func fromStoryboard() -> Self {
        func fromStoryboardHelper<T>() -> T where T : UIViewController {
            let storyboard = UIStoryboard(name: String(describing: T.self), bundle: nil)
            return storyboard.instantiateInitialViewController() as! T
        }
        return fromStoryboardHelper()
    }
}

extension UIImage {
    func resize(x: Int = 0, y: Int = 0, width: Int, height: Int) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 2.0)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func cvPixelBuffer() -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(self.size.width),
                                         Int(self.size.height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else { return nil }
        return pixelBuffer
    }
}

extension CVPixelBuffer {
    func cvPixelData() -> UnsafeMutableRawPointer? {
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(self)
        return pixelData
    }
}
