//
//  MyViewController.swift
//  IM
//
//  Created by Nemo on 2016/11/16.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit

class MyViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint(UserModel.shareInstance.token)
        
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
