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
    
    private var imageViews:NSArray?;
    private var animating:Bool?;
    private var totalImages:Int?;
    private var currentlyDisplayingImageViewIndex:Int?;
    private var currentlyDisplayingImageIndex:Int?;
    
    
    
     var kAnimatedImagesViewDefaultTimePerImage = 20.0;
     var noImageDisplayingIndex = -1;
     var imageSwappingAnimationDuration = 2.0;
     var imageViewsBorderOffset = 150.0;
    
    open func startAnimating(){
    
        debugPrint(animating as Any)
        if (animating == nil || animating == false) {
            animating = true;
            self.imageSwappingTimer.fire();
        }
    }
    
    open func stopAnimating(){
    
    if (self.animating == true) {
        imageSwappingTimer.fireDate = NSDate.distantPast;
            UIView.animate(withDuration: imageSwappingAnimationDuration, delay: 0.0, options: .beginFromCurrentState, animations: {
                for imageView in self.imageViews!{
                    let img = imageView as! UIImageView;
                    img.alpha = 0.0;
                }
            }, completion: { (finished:Bool) in
                self.currentlyDisplayingImageIndex = self.noImageDisplayingIndex;
                self.animating = false;
            });
        }
    }
    
    func bringNextImage(){
        
        let hide = self.imageViews?.object(at: currentlyDisplayingImageViewIndex!);
        let imageViewToHide = hide as! UIImageView;
        
        currentlyDisplayingImageViewIndex =
            (currentlyDisplayingImageViewIndex == 0) ? 1 : 0;
        
        
        let show = self.imageViews?.object(at: currentlyDisplayingImageViewIndex ?? Int());
        let imageViewToShow = show as! UIImageView;
        
        var nextImageToShowIndex = 0;
        
        repeat {
            print("total",totalImages ?? Int());
            nextImageToShowIndex = AnimatedImagesView.self.randomIntBetweenNumber(minNumber: 0, maxNumber: (totalImages ?? Int())-1);
            
        }while(nextImageToShowIndex == currentlyDisplayingImageIndex);
        
        currentlyDisplayingImageIndex = nextImageToShowIndex;
        
//        print("nextImageToShowIndex",nextImageToShowIndex);
        
        imageViewToShow.image = self.delegate?.animatedImagesView(animatedImagesView: self, index: nextImageToShowIndex);
        
        let  kMovementAndTransitionTimeOffset = 0.1;

        UIView.animate(withDuration: self.timePerImage + imageSwappingAnimationDuration +
            kMovementAndTransitionTimeOffset, delay: 0.0, options: [.beginFromCurrentState,.curveLinear], animations: {
                let randomTranslationValueX = Double(self.imageViewsBorderOffset) * 3.5 - Double(AnimatedImagesView.self.randomIntBetweenNumber(minNumber: 0, maxNumber: Int(self.imageViewsBorderOffset)));
//                print("x:",randomTranslationValueX);
                let translationTransform = CGAffineTransform(translationX:CGFloat(randomTranslationValueX), y:0);
                let result: Int  = AnimatedImagesView.self.randomIntBetweenNumber(minNumber: 115, maxNumber: 120);
                
                let randomScaleTransformValue: CGFloat = CGFloat(result) / 100;
//                print("result:",(randomScaleTransformValue));
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
        totalImages = self.delegate?.animatedImagesNumberOfImages(animatedImagesView: self);
    
        self.imageSwappingTimer.fire();
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self._init();
    }
    
    func _init(){
        let images = NSMutableArray.init();
        for _ in 0 ..< 2 {
            
            let frame = CGRect.init(x:(CGFloat)(-imageViewsBorderOffset*3.3), y: (CGFloat)(-imageViewsBorderOffset), width: self.bounds.size.width +
                (CGFloat)(imageViewsBorderOffset * 2), height: self.bounds.size.height +
                    (CGFloat)(imageViewsBorderOffset * 2));
            let imageView = UIImageView.init(frame:frame);
            imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
            imageView.clipsToBounds = false;
            imageView.contentMode = .scaleAspectFill;
            self.addSubview(imageView);
            
            images.add(imageView);
        }
        
        self.imageViews = NSArray.init(array: images);
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
        let timer = Timer.scheduledTimer(timeInterval: self.timePerImage, target: self, selector:#selector(bringNextImage), userInfo: nil, repeats: true);
        return timer;
    }();
    
    lazy var timePerImage: TimeInterval = {
        return self.kAnimatedImagesViewDefaultTimePerImage;
    
    }();
    

    var delegate:AnimatedImagesViewDelegate?{
        
        didSet{
            totalImages = self.delegate?.animatedImagesNumberOfImages(animatedImagesView: self);
        }
    }
    
    deinit {
        self.imageSwappingTimer.invalidate();
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
