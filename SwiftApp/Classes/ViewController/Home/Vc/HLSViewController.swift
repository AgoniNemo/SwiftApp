//
//  HLSViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/9/29.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class HLSViewController: RootViewController {

    var model:VideoModel?
    var vModel = PlayVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
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
