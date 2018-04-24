//
//  ViewController.swift
//  DemoDocPicker
//
//  Created by indianic on 10/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIButtonMasterDocumentPickerDelegate,UIButtonMasterDocumentUploaderDelegate {

    @IBOutlet weak var documentUploader: UIButtonMasterDocumentUploader!
    @IBOutlet weak var documentPicker: UIButtonMasterDocumentPicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentPicker.allowedFileTypes = ["pdf","png","jpeg","txt","docx","doc"]
        documentUploader.exportFILEURL = "http://www.fortune3.com/blog/wp-content/uploads/2012/08/seo-url-structure-ecommerce.jpg"
        documentUploader.exportFILENAME = "image.jpg"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func shouldOpenMasterDocumentPicker(picker: UIButtonMasterDocumentPicker) -> Bool {
        return true
    }
    func masterDocumentDidFinishPicking(picker: UIButtonMasterDocumentPicker, fileURL: URL, fileExtension: String) {
        
        print(fileURL)
        print(fileExtension)
        
    }

    func shouldUploadDocument(uploaded: UIButtonMasterDocumentUploader) -> Bool {
        
        return true
    }
    func masterDocumentUploaded(uploader: UIButtonMasterDocumentUploader, fileURL: URL, fileExtension: String) {
        
    }
}

