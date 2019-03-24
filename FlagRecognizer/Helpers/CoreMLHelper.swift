//
//  CoreMLHelper.swift
//  FlagRecognizer
//
//  Created by Josip Rezic on 24/03/2019.
//  Copyright © 2019 Josip Rezic. All rights reserved.
//


import CoreML
import UIKit

class CoreMLHelper {
    
    //
    // MARK: - VARIABLES
    //
    
    private static var model = FlagImageClassifier()
    
    //
    // MARK: - PRIVATE METHODS
    //
    
    private static func convertPixelsDataIntoDeviceDependentRgbColorSpace( _ image: UIImage, _ pixelBuffer: CVPixelBuffer?) {
        guard let pixelBuffer = pixelBuffer, let pixelData = pixelBuffer.cvPixelData() else { return }
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: pixelData,
                                width: Int(image.size.width),
                                height: Int(image.size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                space: rgbColorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else { return }
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsPushContext(context)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
    }
    
    //
    // MARK: - PUBLIC METHODS
    //
    
    public static func predict(image: UIImage) -> FlagImageClassifierOutput? {
        let newImage = image.resize(width: 299, height: 299)
        guard let pixelBuffer = newImage.cvPixelBuffer() else { return nil }
        convertPixelsDataIntoDeviceDependentRgbColorSpace(newImage, pixelBuffer)
        guard let prediction = try? self.model.prediction(image: pixelBuffer) else { return nil }
        return prediction
    }
}
