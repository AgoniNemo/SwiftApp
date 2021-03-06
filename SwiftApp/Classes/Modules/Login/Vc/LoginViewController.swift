//
//  LoginViewController.swift
//  IM
//
//  Created by Nemo on 2016/11/5.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate,AnimatedImagesViewDelegate,LoginVModelDelegate{
    
    var vModle = LoginVModel();
    
    var isBack:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.view.backgroundColor = UIColor.white;
        
        self.view.addSubview(self.animatedImagesView);
        
        self.view.addSubview(self.bgView);
        
        let x:CGFloat = 50;
        let userTF = LineTextField.init(frame: XCGRect(x, SCREEN_HEIGH/2+50, SCREEN_WIDTH-x*2, 20));
        userTF.placeholder(color:UIColor.white,string:"账号");
        
        userTF.leftView = UIImageView.init(image: #imageLiteral(resourceName: "email"))
        userTF.leftViewMode = UITextField.ViewMode.always;
        userTF.delegate = self;
        self.bgView.addSubview(userTF);
        
        let passTF = LineTextField.init(frame: XCGRect(x, (userTF.frame.maxY)+20, SCREEN_WIDTH-x*2, 20));
        passTF.placeholder(color:UIColor.white,string:"密码");
        passTF.leftView = UIImageView.init(image: #imageLiteral(resourceName: "password"))
        passTF.leftViewMode = UITextField.ViewMode.always;
        passTF.delegate = self;
        passTF.isSecureTextEntry = true
        self.bgView.addSubview(passTF);
        
        let btn = UIButton.init(type: UIButton.ButtonType.system);
        btn.frame = XCGRect(x, passTF.frame.maxY+20, passTF.frame.width, 40);
        btn.setTitle("登录", for: UIControl.State.normal);
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal);
        btn.backgroundColor = RGBA(r: 201, g: 39, b: 143, a: 1);
        btn.alpha = 0.8;
        btn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside);
        self.bgView.addSubview(btn);
        
        vModle.delegate = self;
        userTF.addTarget(self, action: #selector(userNameChanged), for: .editingChanged)
        passTF.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        
        let w:CGFloat = 100.0
        let registerBtn = UIButton.init(type: .system)
        registerBtn.frame = XCGRect((SCREEN_WIDTH-w)/2, SCREEN_HEIGH-40, w, 30)
        registerBtn.addTarget(self, action: #selector(registerClick), for: UIControl.Event.touchUpInside);
        registerBtn.setTitle("注册", for: .normal)
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        registerBtn.setTitleColor(UIColor.white, for: .highlighted)
        self.bgView.addSubview(registerBtn)
        
    }
    
    @objc func registerClick() -> Void {
        self.load(text: "注册中...")
        self.showTextField { [weak self](user, pwd,code) in
            self?.vModle.register(user: user,pwd: pwd,invitationCode: code)
        }
    }
    
    func alertInfo(text:String) {
        XLogLine(text)
        self.hidden()
        self.show(text: text)
    }
    
    func loginSuccess() {
        self.hidden()
        self.animatedImagesView.stopAnimating();
        self.view.endEditing(true)
        if isBack == false {
            self.navigationController?.pushViewController(self.homeTabbarController, animated: false);
        }else{
            self.dismiss(animated: false, completion: { })
        }
        
    }
    
    
    @objc dynamic func userNameChanged(field: LineTextField) {
        vModle.userNameDidChange(text: field.text)
    }
    
    @objc dynamic func passwordChanged(field: LineTextField) {
        vModle.passwordDidChange(text: field.text)
    }
    
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
    
    @objc func btnClick(){
        self.load(text: "load...")
        view.endEditing(true)
        vModle.login()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if self.bgView.y == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.bgView.y = -120;
            })
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.y = 0;
        })
    }
    
    
    lazy var homeTabbarController: UITabBarController = {
        
        let tab = UITabBarController.init();
        
        let homeVc = HomeViewController();
        homeVc.title = "首页";
        homeVc.tabBarItem = UITabBarItem.init(title: "首页", image:UIImage.init(named: "nav_home"), selectedImage:UIImage.init(named: "nav_home_s"));
        
        let categoriesVc = CategoriesViewController();
        categoriesVc.title = "分类";
        categoriesVc.tabBarItem = UITabBarItem.init(title: "分类", image:UIImage.init(named: "nav_discover"), selectedImage: UIImage.init(named: "nav_discover_s"));
        
        let myVc = MyViewController();
        myVc.title = "我";
        myVc.tabBarItem = UITabBarItem.init(title: "我", image: UIImage.init(named: "nav_me"), selectedImage: UIImage.init(named: "nav_me_s"));
        
        let navH = UINavigationController.init(rootViewController: homeVc);
        let navC = UINavigationController.init(rootViewController: categoriesVc);
        let navM = UINavigationController.init(rootViewController: myVc);

        tab.viewControllers = [navH,navC,navM];
        
        return tab;
    }()
    
    lazy var animatedImagesView:AnimatedImagesView = {
    
        let animatedView = AnimatedImagesView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH));
        animatedView.delegate = self;
        

        return animatedView;
    }()
    
    lazy var bgView:UIView = {
    
        let v = UIView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH))
        
        return v;
    }()
    
    
    deinit {
        XLogLine(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
