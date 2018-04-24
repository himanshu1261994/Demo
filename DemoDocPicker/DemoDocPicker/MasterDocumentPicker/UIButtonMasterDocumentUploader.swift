//
//  UIButtonMasterDocumentUploader.swift
//  LawyerApp
//
//  Created by indianic on 21/04/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
import SVProgressHUD
@objc public class UIButtonMasterDocumentUploader: UIButton,MasterDocumentPickerDelegate {

    var exportFILEURL : String? // Should be Http url
    var exportFILENAME : String? //
    
    @IBOutlet open var delegate : Any? {
        get {return internalDelegate}
        set{internalDelegate = newValue as? UIButtonMasterDocumentUploaderDelegate}
        
    }
    var internalDelegate : UIButtonMasterDocumentUploaderDelegate?
    private var docUploader : MasterDocumentPicker?
    private var viewController : UIViewController?
    override public func awakeFromNib() {
        if let del = delegate as? UIViewController {
            viewController = del
        }
        self.addTarget(self, action: #selector(openOptions(_:)), for: .touchUpInside)
    }

    @IBAction func openOptions(_ sender: UIButton) {

        if !MasterDocumentUtility.isConnectedToNetwork() {
        MasterDocumentUtility.showAlertWith(viewController: delegate as!UIViewController, message: MasterDocumentConstant.AlertMessage.kAlertMsgNetworkError)
        }else{
        if internalDelegate!.shouldUploadDocument(uploaded: self) {
            self.downloadFileWith(fileURL: self.exportFILEURL!, documentName: self.exportFILENAME!)
        }
        }
    }
    func shouldOpenDocumentPicker() -> Bool {
        return true
    }
    func documentDidFinishPicking(fileURL: URL, fileExtension: String) {
        internalDelegate?.masterDocumentUploaded(uploader: self, fileURL: fileURL, fileExtension: fileExtension)
    }
    
    func downloadFileWith(fileURL : String,documentName : String) {
    SVProgressHUD.show(withStatus: "Downloading...")
        let destinationFolderUrl = kDocumentDirectoryURL.appendingPathComponent("Downloads")
        let urlToDownload = URL(string: fileURL)
        
   
        if !FileManager.default.fileExists(atPath: destinationFolderUrl.path) {
            do {
                try FileManager.default.createDirectory(atPath: destinationFolderUrl.path, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        let destinationFileUrl =  destinationFolderUrl.appendingPathComponent(documentName)
        if FileManager.default.fileExists(atPath: destinationFileUrl.path) {
            
            do{
                try FileManager.default.removeItem(atPath: destinationFileUrl.path)
            }catch{
                
            }
            
        }
        self.downloadFileWith(url: urlToDownload!, destinationURL: destinationFileUrl)
   
    
        
    }
    func downloadFileWith(url : URL,destinationURL : URL) {
        URLSession.shared.downloadTask(with: url) { (location, response, error) -> Void in
                SVProgressHUD.dismiss()
                guard let location = location else { return }
                do {
                    if (try? FileManager.default.moveItem(at: location, to: destinationURL)) != nil{
                        self.openActionSheetWithURL(url: destinationURL, viewController: self.viewController!)
                        
                    }else{
                        MasterDocumentUtility.showAlertWith(viewController: self.viewController!, message: kErrorSomethingWentWrong)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                    MasterDocumentUtility.showAlertWith(viewController: self.viewController!, message: kErrorSomethingWentWrong)
                    
                }
            }.resume()
    }
    func openActionSheetWithURL(url : URL,viewController : UIViewController)  {
        if MasterDocumentUtility.validateDocumentWith(url: url, viewController: viewController) {
            MasterDocumentUtility.showActionSheetWith(viewController: viewController, message: "Upload Document", buttons: ["ICloud","DropBox"]) { (action,index) in
                if index == 0{
                    self.docUploader = MasterDocumentPicker(type: .iCloud, url: url, delegate: self, viewController:viewController)
                    self.docUploader?.open()
                }else if index == 1{
                    self.docUploader = MasterDocumentPicker(type: .dropBox, url: url, delegate: self, viewController: viewController)
                    self.docUploader?.open()
                }else if index == 2{
                    self.docUploader = MasterDocumentPicker(type: .googleDrive, url: url, delegate: self, viewController: viewController)
                    self.docUploader?.open()
                    
                }
            }
        }
    }
}
