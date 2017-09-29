//
//  PlayViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/21.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: RootViewController,UITableViewDelegate,UITableViewDataSource,VideoPlayerDelegate{

    var model:VideoModel?
    var vModel = PlayVModel()
    
    var _isHalfScreen:Bool = true
    
    var _isBack = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.tabView)
        let url:String = (model?.playPath)!
        
        self.videoPlayer.playConfig(url, view: self.videoPlayBGView)
    }
    
    
    // MARK: - VideoPlayerDelegate
    
    func videoPlayerDidBackButtonClick() {
        
        if _isBack {
            self.videoPlayer.stopVideo()
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        _isHalfScreen = !_isHalfScreen
        debugPrint("-----------:\(_isHalfScreen)")
        _isBack = _isHalfScreen
        
        if _isHalfScreen == true {
            
            UIDevice.current.setValue(NSNumber.init(value: 3), forKey: "orientation")
            UIDevice.current.setValue(NSNumber.init(value: 1), forKey: "orientation")
            UIView.animate(withDuration: 0.5, animations: {
                self.videoPlayBGView.frame = CGRect.init(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.width*0.6)
            })
            self.videoPlayer.fullScreen(!_isHalfScreen)
        }else{
            self.videoPlayer.stopVideo()
            self.dismiss(animated: true, completion: {
                
            })
        }
        
    }
    
    func videoPlayerDidFullScreenButtonClick() {
        
        _isHalfScreen = !_isHalfScreen
        debugPrint("==========:\(_isHalfScreen)")
        _isBack = _isHalfScreen
        
        if _isHalfScreen == true {
            
            UIDevice.current.setValue(NSNumber.init(value: 3), forKey: "orientation")
            UIDevice.current.setValue(NSNumber.init(value: 1), forKey: "orientation")
            UIView.animate(withDuration: 0.5, animations: {
                self.videoPlayBGView.frame = CGRect.init(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.width*0.6)
            })
        }else{
            UIDevice.current.setValue(NSNumber.init(value: 1), forKey: "orientation")
            UIDevice.current.setValue(NSNumber.init(value: 3), forKey: "orientation")
            UIView.animate(withDuration: 0.5, animations: {
                self.videoPlayBGView.frame = self.view.bounds
            })
            
        }
//        self.navigationController?.navigationBar.isHidden = !_isHalfScreen
        self.videoPlayer.fullScreen(!_isHalfScreen)
    }
    
    lazy var videoPlayer: VideoPlayer = {
        let v = VideoPlayer.init()
        v.delegate = self
        return v
    }()
    
    lazy var videoPlayBGView: UIView = {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.width*0.6))
        view.backgroundColor = UIColor.black
        
        self.view.addSubview(view)
        
        return view
    }()
    

    // MARK: - tableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ReplyCell.cell(WithTableView: tableView)
        
        cell.setModel(model: vModel.rowModel(row: indexPath.row))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    lazy var tabView:UITableView = {
        let y:CGFloat = self.view.frame.width*0.6 + 20
        let t = UITableView.init(frame: XCGRect(0, y, SCREEN_WIDTH, SCREEN_HEIGH-y))
        
        t.delegate = self;
        t.dataSource = self;
        t.rowHeight = 90
        t.showsVerticalScrollIndicator = false
        
        
        return t
        
    }()
    
    override var shouldAutorotate: Bool{
        
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        
        if _isHalfScreen{
            return .portrait
        }
        
        return .landscape
        
    }
    deinit {
        debugPrint("释放:\(self)")
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
