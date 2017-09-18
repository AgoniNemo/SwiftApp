//
//  UIViewCotroller+Alert.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/18.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView


enum AlertType: Int {
    case show = 0
    case load = 1
}

class Alert {
    
    
}

extension UIViewController{

    func show(text:String) -> Void {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.showTitle(
            "",
            subTitle: text, 
            style: .wait,
            duration: 1.5
        )
    }

}
