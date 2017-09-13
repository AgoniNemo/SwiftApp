//
//  LoginViewController.swift
//  IM
//
//  Created by Nemo on 2016/11/5.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate,AnimatedImagesViewDelegate{

    var  userTF:LineTextField?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.view.backgroundColor = UIColor.white;
        
        self.view.addSubview(self.animatedImagesView);
    
        
        let x = 50;
        userTF = LineTextField.init(frame: XCGRect(x: CGFloat(x), y: SCREEN_HEIGH/2+50, width: SCREEN_WIDTH-CGFloat(x)*2, height: 20));
        userTF?.placeholder(color:UIColor.white,string:"账号");
        
        userTF?.leftView = UIImageView.init(image: #imageLiteral(resourceName: "email"))
        userTF?.leftViewMode = UITextFieldViewMode.always;
        userTF?.delegate = self;
        self.view.addSubview(userTF!);
        
        let passTF = LineTextField.init(frame: XCGRect(x: CGFloat(x), y: (userTF?.frame.maxY)!+20, width: SCREEN_WIDTH-CGFloat(x)*2, height: 20));
        passTF.placeholder(color:UIColor.white,string:"密码");
        passTF.leftView = UIImageView.init(image: #imageLiteral(resourceName: "password"))
        passTF.leftViewMode = UITextFieldViewMode.always;
        self.view.addSubview(passTF);
        
        let btn = UIButton.init(type: UIButtonType.system);
        btn.frame = XCGRect(x: CGFloat(x), y: passTF.frame.maxY+20, width: passTF.frame.width, height: 40);
        btn.setTitle("登录", for: UIControlState.normal);
        btn.setTitleColor(UIColor.white, for: UIControlState.normal);
        btn.backgroundColor = HOMECOLOR;
        btn.alpha = 0.8;
        btn.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside);//#selector(btnClick(_:))
        self.view.addSubview(btn);
        
    }
    /**
     func btnClick(_ button:UIButton){
     
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.animatedImagesView.startAnimating();
    }
    func animatedImagesNumberOfImages(animatedImagesView: AnimatedImagesView) -> Int {
        return 2;
    }
    func animatedImagesView(animatedImagesView: AnimatedImagesView, index: NSInteger) -> UIImage {
        return #imageLiteral(resourceName: "login_back");
    }
    func btnClick(){
        self.animatedImagesView.stopAnimating();
        self.navigationController?.pushViewController(self.homeTabbarController, animated: false);
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userTF {
            UIView.animate(withDuration: 0.25, animations: { 
                
            })
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
    lazy var homeTabbarController: UITabBarController = {
        
        let tab = UITabBarController.init();
        
        let homeVc = HomeViewController();
        homeVc.title = "首页";
        homeVc.tabBarItem = UITabBarItem.init(title: "首页", image:#imageLiteral(resourceName: "home_icon"), selectedImage: #imageLiteral(resourceName: "home_icon"));
        
        let categoriesVc = CategoriesViewController();
        categoriesVc.title = "分类";
        categoriesVc.tabBarItem = UITabBarItem.init(title: "分类", image: #imageLiteral(resourceName: "categories_icon"), selectedImage: #imageLiteral(resourceName: "categories_icon"));
        
        let myVc = MyViewController();
        myVc.title = "我";
        myVc.tabBarItem = UITabBarItem.init(title: "我", image: #imageLiteral(resourceName: "me_icon"), selectedImage: #imageLiteral(resourceName: "me_icon"));
        
        let navH = UINavigationController.init(rootViewController: homeVc);
        let navC = UINavigationController.init(rootViewController: categoriesVc);
        let navM = UINavigationController.init(rootViewController: myVc);

        tab.viewControllers = [navH,navC,navM];
        
        return tab;
    }()
    
    lazy var animatedImagesView:AnimatedImagesView = {
    
        let animatedView = AnimatedImagesView.init(frame: XCGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGH));
        animatedView.delegate = self;
        animatedView.startAnimating();

        return animatedView;
    }()
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}