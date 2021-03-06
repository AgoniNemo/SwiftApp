//
//  DownloadManager.swift
//  AVFoundationDemo
//
//  Created by Mjwon on 2017/9/26.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit


protocol DownloadManagerDelegate:class {
    
    /** 没有完整的缓存文件，告诉播放器自己去用 网络地址 进行播放 */
    func didNoCacheFile(_ manager:DownloadManager)->Void
    
    /** 已经存在下载好的这个文件了，告诉播放器可以直接利用filePath播放 */
    func didFileExisted(_ manager:DownloadManager,_ filePath:String) -> Void
    
    /** 开始下载数据(包括长度和类型) */
    func didStartReceive(_ manager:DownloadManager,_ videoLength:Int) -> Void
    
    /** 正在下载 */
    func didReceiveManager(_ manager:DownloadManager,_ progress:CGFloat) -> Void

    /** 完成下载 */
    func didFinishLoading(_ manager:DownloadManager,_ filePath:String) -> Void

    func didFailLoading(_ manager:DownloadManager,_ errorCode:Error) -> Void

}

class DownloadManager:NSObject,URLSessionDataDelegate {
    
    weak var delegate:DownloadManagerDelegate?
    private var videoUrl:String = ""
    private let fileManager = FileManager.default
    private var fileHandle:FileHandle?
    private var curruentLength:CGFloat = 0.0
    private var dataTask:URLSessionDataTask?
    private var totalLength:UInt64?
    
    //定义文件的临时下载路径
    private var videoTempPath:String = ""
    
    //定义文件的缓存路径
    private var videoCachePath:String = ""
    
    init(_ videoUrl:String,_ delegate:DownloadManagerDelegate) {
        super.init()
        
        self.delegate = delegate
        self.videoUrl = videoUrl
        
        self.fileJudge()
    }
    
    private func fileJudge() -> Void {
        let videoName:String = self.videoUrl.components(separatedBy: "/").last!
        self.videoTempPath = String.tempFilePath(fileName: videoName)
        
        self.videoCachePath = String.cacheFilePath(fileName: videoName)
        
        XLogLine("videoTempPath === \(self.videoTempPath))")
        XLogLine("videoCachePath === \(self.videoCachePath))")
        
        if self.fileManager.fileExists(atPath: self.videoCachePath) {
            XLogLine("---缓存目录下已存在下载完成的文件可以直接播放---")
            self.delegate?.didFileExisted(self, self.videoCachePath)
        }else{
            
            if self.fileManager.fileExists(atPath: self.videoTempPath) {
                self.fileHandle = FileHandle.init(forUpdatingAtPath: self.videoTempPath)
                curruentLength = CGFloat((self.fileHandle?.seekToEndOfFile())!)
                XLogLine("---当前目录已存在下载的临时文件：\(curruentLength)---")
            }else{
                curruentLength = 0
                fileManager.createFile(atPath: self.videoTempPath, contents: nil, attributes: nil)
                fileHandle = FileHandle.init(forUpdatingAtPath: self.videoTempPath)
            }
            
            self.sendHttpRequst()
            
            self.delegate?.didNoCacheFile(self)
        }
        
    }
    
    func sendHttpRequst() -> Void {
        
        fileHandle?.seekToEndOfFile()
        
        let url = URL.init(string: videoUrl)
        var request = URLRequest.init(url: url!)
        
        XLogLine("curruentLength:\(self.curruentLength)")
        
        //指定头信息  当前已下载的进度
        request.setValue("bytes=\(Int(self.curruentLength))-", forHTTPHeaderField: "Range")
        
        XLogLine(request.allHTTPHeaderFields!)
        
        //创建请求
        dataTask = self.session.dataTask(with: request)
        
        dataTask?.resume()
        
    }
    
    // MARK: - delegate
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        let http = response as? HTTPURLResponse
        let dic:Dictionary = (http?.allHeaderFields)!
        
        XLogLine(dic)
        
        guard let content:String = dic["Content-Range"] as? String else {
            XLogLine("---urlSession出错---")
            return
        }

        let array = content.components(separatedBy: "/")
        let length = array.last
        
        var videoLength:Int64?
        
        if Int(length!)! == 0 {
            videoLength = (http?.expectedContentLength)!
        }else{
            videoLength = Int64(length!)!
        }
        
        //接受到响应的时候 告诉系统如何处理服务器返回的数据
        completionHandler(.allow)
        
        //得到请求文件的数据大小
        totalLength = UInt64(response.expectedContentLength) + UInt64(curruentLength)
        
        XLogLine("请求文件的数据大小:\(String(describing: totalLength))")
        
        self.delegate?.didStartReceive(self, Int(videoLength!))
        
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        fileHandle?.write(data)
        
        curruentLength += CGFloat(data.count)
        
        let progress = 1.0 * curruentLength / CGFloat(totalLength!)
        
        self.delegate?.didReceiveManager(self, progress)
        
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            
            let tempPathURL = URL.init(fileURLWithPath: self.videoTempPath)
            let cachefileURL = URL.init(fileURLWithPath: self.videoCachePath)
            
            XLogLine("videoCachePath === \(self.videoTempPath)")
            
            
            if self.fileManager.fileExists(atPath: self.videoCachePath) == false {
                XLogLine("createDirectoryCachefileURL === \(self.videoCachePath)")
                do {
                    try self.fileManager.createDirectory(atPath: self.videoCachePath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    XLogLine("createDirectory fail:\(error)")
                }
            }
            
            if self.fileManager.fileExists(atPath: cachefileURL.path, isDirectory: nil) {
                do {
                    try self.fileManager.removeItem(at: cachefileURL)
                } catch {
                    XLogLine("removeItem fail:\(error)")
                }
            }
            
            do {
                try self.fileManager.moveItem(at: tempPathURL, to: cachefileURL)
            } catch {
                 XLogLine("moveItem fail:\(error)")
            }
            
            self.delegate?.didFinishLoading(self, self.videoCachePath)
        }else{
            self.delegate?.didFailLoading(self, error!)
        }
        
        
    }
    
    //开始/继续
    func start() -> Void {
        XLogLine("---开始---")
        if self.dataTask == nil {
            self.sendHttpRequst()
        }else{
            self.dataTask?.resume()
        }
    }
    
    func suspend() -> Void {
        XLogLine("---暂停---")
        self.dataTask?.suspend()
    }
    
    func cancel() -> Void {
        XLogLine("---取消---")
        self.dataTask?.cancel()
        self.dataTask = nil
    }
    
    lazy var session: URLSession = {
        let s = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        return s
    }()
    
    
    // MARK: - lazy

    
    
}
