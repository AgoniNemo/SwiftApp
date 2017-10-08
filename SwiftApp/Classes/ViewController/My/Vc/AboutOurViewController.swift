//
//  AboutOurViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class AboutOurViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于我们"
        
        setBackButton()
        
        let r:CGFloat = 80.0
        let iconView = UIImageView.init(frame: XCGRect((SCREEN_WIDTH-r)/2, (SCREEN_HEIGH-r)/2-50, r, r))
        iconView.image = #imageLiteral(resourceName: "erotic-sexy-girl-icon")
        
        iconView.layer.cornerRadius = 20
        iconView.layer.borderWidth = 0.2
        iconView.layer.borderColor = UIColor.clear.cgColor
        
        iconView.layer.shadowColor = UIColor.black.cgColor
        iconView.layer.shadowOpacity = 1
        iconView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        
        self.view.addSubview(iconView)
        
        let infoDictionary = Bundle.main.infoDictionary
        
        let version = UILabel.init(frame: XCGRect(0, iconView.maxY!+10, SCREEN_WIDTH, 20))
        
        
        version.text = "版本 \(infoDictionary?["CFBundleVersion"] ?? String()).0"
        version.textAlignment = .center
        version.textColor = UIColor.lightGray
        self.view.addSubview(version)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
