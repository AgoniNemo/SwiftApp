//
//  PlayViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/21.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: RootViewController{

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
        
        debugPrint(url)
        
        model?.save()
        vModel.id = (model?.id)!
        vModel.delegate = self
        vModel.loadingMore()
        
        self.videoPlayer.playConfig(url, view: self.videoPlayBGView)
        
        setBottomButton()
    }
    
    func setBottomButton() -> Void{
        
        let w = SCREEN_WIDTH/2
        let commitBtn = UIButton.init(type: .system)
        commitBtn.frame = XCGRect(w, SCREEN_HEIGH-40, w, 40)
        commitBtn.setTitle("回  复", for: .normal)
        commitBtn.setTitleColor(UIColor.white, for: .normal)
        commitBtn.backgroundColor = HOMECOLOR
        
        commitBtn.addTarget(self, action: #selector(commitAction), for: UIControlEvents.touchUpInside);
        
        self.view.addSubview(commitBtn)
        
        
        let collectBtn = UIButton.init(type: .system)
        collectBtn.frame = XCGRect(0, SCREEN_HEIGH-40, w, 40)
        collectBtn.tintColor = UIColor.clear
        collectBtn.isSelected = (self.model?.verifyCollect())!
        collectBtn.setTitle("收藏", for: .normal)
        collectBtn.setTitle("取消收藏", for: .selected)
        collectBtn.setTitleColor(UIColor.white, for: .normal)
        collectBtn.backgroundColor = UIColor.black
        
        collectBtn.addTarget(self, action: #selector(collectAction(_:)), for: UIControlEvents.touchUpInside);
        
        self.view.addSubview(collectBtn)
    
    }
    
    func collectAction(_ button:UIButton) -> Void {
        button.isSelected = !button.isSelected
        self.model?.collect(b: button.isSelected)
    }
    
    func commitAction() -> Void {
        self.editTextField {[weak self](content) in
            
            self?.vModel.commit(text: content)
        }
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
    
    
    lazy var tabView:UITableView = {
        let y:CGFloat = self.view.frame.width*0.6
        let t = UITableView.init(frame:  XCGRect(0, y+20, SCREEN_WIDTH, SCREEN_HEIGH-y-40-20), style: .grouped)
        
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

}
extension PlayViewController:PlayVModelDelegate{
    
    func alertload() {
        
    }

    func alertInfo(text:String){
        self.show(text: text)
    }
    
    func reloadData(){
    
        self.tabView.reloadData()
    }
}

extension PlayViewController:UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ReplyCell.cell(WithTableView: tableView)
        
        cell.setModel(model: vModel.indexPathModel(indexPath: indexPath))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

}

extension PlayViewController:VideoPlayerDelegate{

    
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

}
