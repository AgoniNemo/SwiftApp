//
//  InformationViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class InformationViewController: RootViewController {

    typealias Closure = (()->())
    var refreshImageClosure:Closure?
    
    let vModel = InfoVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        setBackButton()
        
        vModel.delegate = self
        vModel.loadingMore()
        
        self.view.addSubview(self.tabView)
    
    }
    
    lazy var tabView: UITableView = {
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), style: .grouped)
        t.delegate = self
        t.dataSource = self
        t.tableFooterView = UIView()
        
        return t
    }()

    lazy var imagePick: UIImagePickerController = {
        let i = UIImagePickerController.init()
        i.delegate = self
        i.modalPresentationStyle = .overFullScreen
        i.allowsEditing = true
        return i
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension InformationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let data = UIImageJPEGRepresentation(image, 0.7)
        
        self.vModel.uploadImage(data: data!)
        
    }
    
}

extension InformationViewController:InfoVModelDelegate{

    func alertload() {
        self.load(text: "上传中...")
    }
    
    func reloadData() {
        self.hidden()
        self.tabView.reloadData()
    }
    
    func alertInfo(text: String) {
        self.show(text: text)
    }
}

extension InformationViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return vModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyInfoCell.cell(WithTableView: tabView)
        
        cell.setModel(model:vModel.indexPathModel(indexPath: indexPath))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            let vc = ModifyInfoViewController()
            vc.type = ModifyType(rawValue: indexPath.row)!
            vc.model = vModel.indexPathModel(indexPath: indexPath)
            vc.closure = {[weak self]()->() in
                self?.vModel.loadingMore()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            showActionSheet()
        }
        
    }
    
    func showActionSheet() -> Void {
        
        let clickedHandler = { [weak self](sheetView: ActionSheetView, index: Int) in
            debugPrint("点击\(index)")
            self?.selectAction(index: index)
        }
        
        let otherButtonTitles = ["拍照", "相册"]
        let actionSheet = ActionSheetView(cancelButtonTitle: "取消",
                                          otherButtonTitles: otherButtonTitles,
                                          clickedHandler: clickedHandler)
        actionSheet.show()
    }
    
    func selectAction(index:Int) -> Void {
        
        if index == 0 {
            return
        }
        
        var sourceType:UIImagePickerControllerSourceType = .photoLibrary
        if (index == 1) {
            sourceType = .camera
        }else if (index == 2){
            sourceType = .photoLibrary
        }
        self.imagePick.sourceType = sourceType
        self.present(self.imagePick, animated: true, completion: nil)
    }
    
}
