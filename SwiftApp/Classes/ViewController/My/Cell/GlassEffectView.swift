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
            
        }
        
        get { return self._header }
    }
    

    func setImage(url:String,image:UIImage? = #imageLiteral(resourceName: "header")) -> Void {
        
        let iUrl = URL.init(string: url)

        self.bgView.kf.setImage(with: iUrl, placeholder: image)
        self.headerView.kf.setImage(with: iUrl, placeholder: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.bgView)
        self.addSubview(self.headerView)
    }
    
    lazy var headerView: UIImageView = {
        
        let radius:CGFloat = 150.0
        
        let x = (self.width! - radius)/2
        let y = (self.height! - radius)/2
        let h:UIImageView = UIImageView.init(frame: XCGRect(x, y, radius, radius))
        h.layer.masksToBounds = true
        h.layer.cornerRadius = radius/2
        
        h.layer.borderWidth = 5
        h.layer.borderColor = RGBA(r: 255, g: 255, b: 255, a: 0.6).cgColor
        
        h.layer.shadowColor = UIColor.black.cgColor
        h.layer.shadowOpacity = 5
        h.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        
        return h
    }()
    
    lazy var bgView: UIImageView = {
        let b:UIImageView = UIImageView.init(frame: self.bounds)
        b.isUserInteractionEnabled = true
        b.backgroundColor = UIColor.white
        
        //首先创建一个模糊效果
        /**
         case extraLight 特别亮
         
         case light 亮
         
         case dark 暗
         */
        let blurEffect = UIBlurEffect(style: .dark)
        //接着创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.75
        //设置模糊视图的大小
        blurView.frame.size = b.bounds.size
        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
        b.addSubview(blurView)
        
        return b
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        debugPrint(self)
        
        //绘制到指定的矩形中，注意如果大小不合适会会进行拉伸
        self.header?.setGaussianBlur().draw(in: self.bounds)
        
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
        
    }*/

}

