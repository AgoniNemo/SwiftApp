//
//  RootViewController.swift
//  IM
//
//  Created by Nemo on 2016/11/16.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UIGestureRecognizerDelegate{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
    }
    
    func setBackButton() -> Void {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        let btn = UIButton.init(type: .custom)
        btn.frame = XCGRect(0, 0, 20, 20)
        btn.setImage(#imageLiteral(resourceName: "towards_white_left"), for: .normal)
        
        btn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside);
        
        let item = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = item;
        
    }
    
    @objc private func backAction()->Void{
        self.navigationController?.popViewController(animated: true)
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
