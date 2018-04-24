//
//  ViewController.swift
//  ImageProcessingDemo
//
//  Created by indianic on 07/09/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import AssetsLibrary

class ViewController: UIViewController,MPMediaPickerControllerDelegate,UINavigationControllerDelegate ,UIVideoEditorControllerDelegate,FaveButtonDelegate {
    @IBOutlet weak var btnFv: FaveButton!

    var videoURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        var uiImages = [UIImage]()
        uiImages.append(UIImage.init(named: "1")!)
        uiImages.append(UIImage.init(named: "2")!)
        uiImages.append(UIImage.init(named: "3")!)
        uiImages.append(UIImage.init(named: "4")!)
        uiImages.append(UIImage.init(named: "5")!)
        uiImages.append(UIImage.init(named: "1")!)
        uiImages.append(UIImage.init(named: "2")!)
        uiImages.append(UIImage.init(named: "3")!)
        uiImages.append(UIImage.init(named: "4")!)
        uiImages.append(UIImage.init(named: "5")!)
  
        
        
        
//        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecH264, width: (uiImages[0].cgImage?.width)!, height: (uiImages[0].cgImage?.height)!)
//        let movieMaker = CXEImagesToVideo(videoSettings: settings)
//        movieMaker.createMovieFrom(images: uiImages){ (fileURL:URL) in
//            
//            print(fileURL.absoluteString)
//            
//            self.videoURL = fileURL
//            
//            
//            if UIVideoEditorController.canEditVideo(atPath: fileURL.path) {
//                let editController = UIVideoEditorController()
//                editController.videoPath = fileURL.path
//                editController.delegate = self
//                self.present(editController, animated:true)
//            }
//            
//            
////            self.mergeFilesWithUrl(videoUrl: self.videoURL!, audioUrl: URL.init(fileURLWithPath: Bundle.main.path(forResource: "A1", ofType: "mp3")!))
//            
//            
//        }
    }
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]? {
        
        return nil
    }
    @IBAction func btnMediaPickerAction(_ sender: UIButton) {
//        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
//        mediaPicker.delegate = self
//        mediaPicker.allowsPickingMultipleItems = false
//        self.present(mediaPicker, animated: true, completion: nil)
//        let videoURL = NSURL(string: "https://player.vimeo.com/video/234634968")
//        let player = AVPlayer(url: videoURL! as URL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
        
        if btnFv.isSelected {
            btnFv.isSelected = false
        }else{
            btnFv.isSelected = true
        }
    }
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
      
        
        print("you picked: \(mediaItemCollection)")
        
        mediaPicker.dismiss(animated: true) { 
            self.mergeFilesWithUrl(videoUrl: self.videoURL!, audioUrl: mediaItemCollection.items[0].assetURL!)
        }
        
        
    }
    func mergeFilesWithUrl(videoUrl:URL, audioUrl:URL)
    {
        let mixComposition : AVMutableComposition = AVMutableComposition()
        var mutableCompositionVideoTrack : [AVMutableCompositionTrack] = []
        var mutableCompositionAudioTrack : [AVMutableCompositionTrack] = []
        let totalVideoCompositionInstruction : AVMutableVideoCompositionInstruction = AVMutableVideoCompositionInstruction()
        
        
        //start merge
        
        let aVideoAsset : AVAsset = AVAsset.init(url: videoUrl)
        let aAudioAsset : AVAsset = AVAsset.init(url: audioUrl)
        
        mutableCompositionVideoTrack.append(mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid))
        mutableCompositionAudioTrack.append( mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid))
        
        let aVideoAssetTrack : AVAssetTrack = aVideoAsset.tracks(withMediaType: AVMediaTypeVideo)[0]
        let aAudioAssetTrack : AVAssetTrack = aAudioAsset.tracks(withMediaType: AVMediaTypeAudio)[0]
        
        
        
        do{
            try mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(kCMTimeZero, aVideoAssetTrack.timeRange.duration), of: aVideoAssetTrack, at: kCMTimeZero)
            
            //In my case my audio file is longer then video file so i took videoAsset duration
            //instead of audioAsset duration
            
            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(kCMTimeZero, aVideoAssetTrack.timeRange.duration), of: aAudioAssetTrack, at: kCMTimeZero)
            
            //Use this instead above line if your audiofile and video file's playing durations are same
            
            //            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(kCMTimeZero, aVideoAssetTrack.timeRange.duration), ofTrack: aAudioAssetTrack, atTime: kCMTimeZero)
            
        }catch{
            
        }
        
        totalVideoCompositionInstruction.timeRange = CMTimeRangeMake(kCMTimeZero,aVideoAssetTrack.timeRange.duration )
        
        let mutableVideoComposition : AVMutableVideoComposition = AVMutableVideoComposition()
        mutableVideoComposition.frameDuration = CMTimeMake(1, 30)
        
        mutableVideoComposition.renderSize = CGSize.init(width: 1270, height: 720)
        
        //        playerItem = AVPlayerItem(asset: mixComposition)
        //        player = AVPlayer(playerItem: playerItem!)
        //
        //
        //        AVPlayerVC.player = player
        
        
        
        //find your video on this URl
        let savePathUrl : NSURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/newVideo.mp4")
        print(savePathUrl.absoluteString ?? "NIL")
        
        if FileManager.default.fileExists(atPath: savePathUrl.path!) {
            
            do {
                try FileManager.default.removeItem(atPath: savePathUrl.path!)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        assetExport.outputFileType = AVFileTypeMPEG4
        assetExport.outputURL = savePathUrl as URL
        assetExport.shouldOptimizeForNetworkUse = true
        
        assetExport.exportAsynchronously { () -> Void in
            switch assetExport.status {
                
            case AVAssetExportSessionStatus.completed:
                
                //Uncomment this if u want to store your video in asset
                
                //let assetsLib = ALAssetsLibrary()
                //assetsLib.writeVideoAtPathToSavedPhotosAlbum(savePathUrl, completionBlock: nil)
//                UISaveVideoAtPathToSavedPhotosAlbum(savePathUrl.absoluteString!, nil, nil, nil)
                
                
                let player = AVPlayer(url: savePathUrl as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                
                
                print("success")
            case  AVAssetExportSessionStatus.failed:
                print("failed \(String(describing: assetExport.error))")
            case AVAssetExportSessionStatus.cancelled:
                print("cancelled \(String(describing: assetExport.error))")
            default:
                print("complete")
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

