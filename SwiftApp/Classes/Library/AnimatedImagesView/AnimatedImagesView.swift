//
//  AnimatedImagesView.swift
//  IM
//
//  Created by Nemo on 2016/12/6.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit


protocol AnimatedImagesViewDelegate:class {
    
    func animatedImagesNumberOfImages(animatedImagesView:AnimatedImagesView) -> Int;

    func animatedImagesView(animatedImagesView:AnimatedImagesView,index:NSInteger) -> UIImage;
    
}

class AnimatedImagesView: UIView {
    
    private var imageViews:[UIImageView] = Array.init();
    private var animating:Bool = false;
    private var totalImages:Int = 0;
    private var currentlyDisplayingImageViewIndex:Int?;
    private var currentlyDisplayingImageIndex:Int?;
    
    
    let kAnimatedImagesViewDefaultTimePerImage:TimeInterval = 20.0;
    var noImageDisplayingIndex = -1;
    var imageSwappingAnimationDuration = 2.0;
    var imageViewsBorderOffset = 150.0;
    
    // 这个方法要注意，在同个界面不要多次执行这会造成动画停止的问题
    public func startAnimating(){

        if (animating == false) {
            animating = true;
            /**
            * 启动计时器
            self.imageSwappingTimer.fire();
            */
            // 计时器继续
            imageSwappingTimer.fireDate = Date.distantPast;
        }
    }
    
    open func stopAnimating(){
    
    if (self.animating == true) {
        // 计时器暂停
        imageSwappingTimer.fireDate = Date.distantFuture;
            UIView.animate(withDuration: imageSwappingAnimationDuration, delay: 0.0, options: .beginFromCurrentState, animations: {
                for imageView in self.imageViews{
                    imageView.alpha = 0.0;
                }
            }, completion: { [weak self](finished:Bool) in
                self?.currentlyDisplayingImageIndex = self?.noImageDisplayingIndex;
                self?.animating = false;
            });
        }
    }
    
    @objc func bringNextImage(){
        
        let imageViewToHide = self.imageViews[currentlyDisplayingImageViewIndex!]

        XLogLine("currentlyDisplayingImageViewIndex\(String(describing: currentlyDisplayingImageViewIndex))");
        currentlyDisplayingImageViewIndex =
            (currentlyDisplayingImageViewIndex == 0) ? 1 : 0;
        
        XLogLine("currentlyDisplayingImageViewIndex\(String(describing: currentlyDisplayingImageViewIndex))");
        
        let imageViewToShow = self.imageViews[currentlyDisplayingImageViewIndex!]
        
        var nextImageToShowIndex = 0;
        
        repeat {
            
            nextImageToShowIndex = AnimatedImagesView.self.randomIntBetweenNumber(minNumber: 0, maxNumber: totalImages - 1);
            
        }while(nextImageToShowIndex == currentlyDisplayingImageIndex);
        
        currentlyDisplayingImageIndex = nextImageToShowIndex;
        
        XLogLine("nextImageToShowIndex:\(nextImageToShowIndex)")
        
        imageViewToShow.image = self.delegate?.animatedImagesView(animatedImagesView: self, index: nextImageToShowIndex);
        
        let  kMovementAndTransitionTimeOffset = 0.1;

        let duration = kAnimatedImagesViewDefaultTimePerImage + imageSwappingAnimationDuration +
        kMovementAndTransitionTimeOffset
                
        UIView.animate(withDuration: duration, delay: 0.0, options: [.beginFromCurrentState,.curveLinear], animations: {
                let randomTranslationValueX = Double(self.imageViewsBorderOffset) * 3.5 - Double(AnimatedImagesView.self.randomIntBetweenNumber(minNumber: 0, maxNumber: Int(self.imageViewsBorderOffset)));
            
                XLogLine("x:\(randomTranslationValueX)");
            
                let translationTransform = CGAffineTransform(translationX:CGFloat(randomTranslationValueX), y:0);
                let result: Int  = AnimatedImagesView.self.randomIntBetweenNumber(minNumber: 115, maxNumber: 120);
                
                let randomScaleTransformValue: CGFloat = CGFloat(result) / 100;
            
                XLogLine("result:\(randomScaleTransformValue)")
            
                let scaleTransform = CGAffineTransform(scaleX:randomScaleTransformValue, y:randomScaleTransformValue);
                
                imageViewToShow.transform = scaleTransform.concatenating(translationTransform);
                
        }, completion: nil);
        
        UIView.animate(withDuration: imageSwappingAnimationDuration, delay: kMovementAndTransitionTimeOffset, options: [.beginFromCurrentState,.curveLinear], animations: {
            
            imageViewToShow.alpha = 1.0;
            imageViewToHide.alpha = 0.0;

        }, completion: { (finished:Bool) in
            if (finished) {
                imageViewToHide.transform = CGAffineTransform.identity;
            }
        });
        
    }
    
    func reloadData(){
        totalImages = (self.delegate?.animatedImagesNumberOfImages(animatedImagesView: self))!;
        /**
        * 启动计时器
        self.imageSwappingTimer.fire();
        */
        // 计时器继续
        self.imageSwappingTimer.fireDate = Date.distantPast;
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self._init();
    }
    
    private func _init(){
        
        self.imageViews = Array.init();
        
        for _ in 0 ..< 2 {
            
            let frame = CGRect.init(x:(CGFloat)(-imageViewsBorderOffset*3.3), y: (CGFloat)(-imageViewsBorderOffset), width: self.bounds.size.width +
                (CGFloat)(imageViewsBorderOffset * 2), height: self.bounds.size.height +
                    (CGFloat)(imageViewsBorderOffset * 2));
            let imageView = UIImageView.init(frame:frame);
            imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
            imageView.clipsToBounds = false;
            imageView.contentMode = .scaleAspectFill;
            self.addSubview(imageView);
            
            self.imageViews.append(imageView)
        }
        
        currentlyDisplayingImageIndex = noImageDisplayingIndex;
        
        currentlyDisplayingImageViewIndex = 0;
    }
    
   
    class func randomIntBetweenNumber(minNumber:Int,maxNumber:Int) -> Int {
        if minNumber > maxNumber {
            return self.randomIntBetweenNumber(minNumber: maxNumber, maxNumber: minNumber);
        }
        
        let result = UInt32(Int(maxNumber) - (minNumber) + Int(1));
        let arc = arc4random() % result
        
        let i = arc+UInt32(minNumber);
//        print("i",i);
        
        return Int(i);
    }


    
    lazy var imageSwappingTimer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: self.kAnimatedImagesViewDefaultTimePerImage, target: self, selector:#selector(bringNextImage), userInfo: nil, repeats: true);
        return timer;
    }();

    var delegate:AnimatedImagesViewDelegate?{
        
        didSet{
            totalImages = (self.delegate?.animatedImagesNumberOfImages(animatedImagesView: self))!;
        }
    }
    
    deinit {
        self.imageSwappingTimer.invalidate();
        XLogLine("释放:\(self)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
/**
 想要在 Swift 中使用 weak delegate，我们就需要将 protocol 限制在 class 内。一种做法是将 protocol 声明为 Objective-C 的，这可以通过在 protocol 前面加上 @objc 关键字来达到，Objective-C 的 protocol 都只有类能实现，因此使用 weak 来修饰就合理了：
 
 @objc protocol MyClassDelegate {
     func method()
 }
 另一种可能更好的办法是在 protocol 声明的名字后面加上 class，这可以为编译器显式地指明这个 protocol 只能由 class 来实现。
 
 protocol MyClassDelegate: class {
     func method()
 }
 相比起添加 @objc，后一种方法更能表现出问题的实质，同时也避免了过多的不必要的 Objective-C 兼容，可以说是一种更好的解决方式。
 
 */
