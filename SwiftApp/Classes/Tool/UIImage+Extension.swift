//
//  UIImage+Extension.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/5.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit
import Accelerate

extension UIImage {
    //生成圆形图片
    func toCircle(_ size:CGSize? = CGSize.init()) -> UIImage {
        
        //取最短边长
        var shotest = min(self.size.width, self.size.height)
        
        if (size?.width)! > CGFloat(0.0) {
            shotest = min((size?.width)!, (size?.height)!)
        }
        
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return maskedImage
    }
    
    
    func setGaussianBlur() -> UIImage {
        
        //获取原始图片
        let inputImage = CIImage(image: self)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(Float(2), forKey: kCIInputRadiusKey)
        
        
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: self.size)
        let context = CIContext(options: nil)
        
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        
        //显示生成的模糊图片
        return UIImage(cgImage: cgImage!)
    }
    
    func gaussianBlur( blurAmount:CGFloat) -> UIImage {
        
        //高斯模糊参数(0-1)之间，超出范围强行转成0.5
        var blurAmount = blurAmount
        if (blurAmount < 0.0 || blurAmount > 1.0) {
            blurAmount = 0.5
        }
        
        var boxSize = Int(blurAmount * 40)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.cgImage
        
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        
        let inProvider =  img!.dataProvider
        let inBitmapData:CFData =  inProvider!.data!
        
        inBuffer.width = vImagePixelCount(img!.width)
        inBuffer.height = vImagePixelCount(img!.height)
        inBuffer.rowBytes = img!.bytesPerRow
        //  UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData))
        let unsafe = UnsafeMutablePointer(mutating: CFDataGetBytePtr(inBitmapData)!)
        
        inBuffer.data = UnsafeMutableRawPointer.init(unsafe)
        
        //手动申请内存
        let pixelBuffer = malloc(img!.bytesPerRow * img!.height)
        
        outBuffer.width = vImagePixelCount(img!.width)
        outBuffer.height = vImagePixelCount(img!.height)
        outBuffer.rowBytes = img!.bytesPerRow
        outBuffer.data = pixelBuffer
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if (kvImageNoError != error)
        {
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            if (kvImageNoError != error)
            {
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                                   &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                                   UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            }
        }
        
        let colorSpace =  CGColorSpaceCreateDeviceRGB()
        let ctx = CGContext(data: outBuffer.data,
                            width: Int(outBuffer.width),
                            height: Int(outBuffer.height),
                            bitsPerComponent: 8,
                            bytesPerRow: outBuffer.rowBytes,
                            space: colorSpace,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let imageRef = ctx!.makeImage()
        
        //手动申请内存
        free(pixelBuffer)
        
        return UIImage.init(cgImage: imageRef!)
    }
    
}
