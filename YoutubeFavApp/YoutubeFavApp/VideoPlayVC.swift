//
//  VideoPlayVC.swift
//  YoutubeFavApp
//
//  Created by indianic on 11/03/1938 Saka.
//  Copyright © 1938 Saka indianic. All rights reserved.
//

import UIKit
import Alamofire
class VideoPlayVC: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        https://www.youtube.com/watch?v=Z3kGD5LD8K8&feature=youtu.be
        
        let url = URL.init(string: "https://www.youtube.com/watch?v=Z3kGD5LD8K8&feature=youtu.be")
        
        
        
        MasterDocumentUtility.downloadFileAt(folder: "TEST", filename: "TEST.mp4", data: Data()) { (url, error) in
            if url != nil{
                print(url!.absoluteString)
                let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                  
                    
                    return (url!, [.removePreviousFile, .createIntermediateDirectories])
                }
                
                Alamofire.download("https://youtu.be/Z3kGD5LD8K8", to: destination).response { response in
                    print(response)
                    
                    if response.error == nil, let imagePath = response.destinationURL?.path {
                        print(imagePath)
                    }
                }
            }
            
        }
   
        
       
        
        
        self.playerView.load(withVideoId:"Z3kGD5LD8K8")
//        self.playerView.load(withPlaylistId: "PL6Rtnh6YJK7YiLb1Dj3o6owWDF6kI8-jI")
    }

    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
