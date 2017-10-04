//
//  GlassEffectView.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class GlassEffectView: UIView {

    private var _header:UIImage = UIImage.init()
    var header:UIImage?{
    
        set(h){
            _header = h!
            self.setNeedsDisplay()
        }
        
        get { return self._header }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        debugPrint(self)
        
        //绘制到指定的矩形中，注意如果大小不合适会会进行拉伸
        self.header?.draw(in: self.bounds)
        
        
        let radius:CGFloat = 150.0
        
        let x = self.center.x - radius/2
        let y = self.center.y - radius/2

        
        let context = UIGraphicsGetCurrentContext()!
        context.addEllipse(in: XCGRect(x, y, radius, radius))
        context.setFillColor(RGBA(r: 255, g: 255, b: 255, a: 0.6).cgColor)
        context.fillPath()
        
        let difference:CGFloat = 8.0

        //从某一点开始绘制
        self.header?.toCircle(CGSize.init(width: radius - difference, height: radius - difference)).draw(at: CGPoint.init(x: x + difference/2, y: y + difference/2))
        
            
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

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
        filter.setValue(Float(8), forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: self.size)
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
                
        //显示生成的模糊图片
        return UIImage(cgImage: cgImage!)
    }
}
