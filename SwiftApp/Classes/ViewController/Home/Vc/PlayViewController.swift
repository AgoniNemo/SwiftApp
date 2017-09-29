//
//  PlayViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/21.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: RootViewController {

    var model:VideoModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.setBackButton()
        
        debugPrint(model?.playPath as Any)
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
