//
//  ViewController.swift
//  YoutubeFavApp
//
//  Created by indianic on 11/03/1938 Saka.
//  Copyright © 1938 Saka indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearchChannel: UITextField!
    var channelArray : [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
   
        txtSearchChannel.delegate = self
        let key = "AIzaSyBL-9jLBoHb_cF7VBcnL643fDX0DFziaeE"
        
        channelArray = getAllChannelsWithKey(key, query: "indianic")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func getAllChannelsWithKey(_ key : String, query : String) -> [[String:Any]] {
        
        // GET Channel Service
        let type = "channel"
        
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(query)&type=\(type)&key=\(key)"

        let response  = nsdataToJSON(getJSON(url)) as! Dictionary<String, Any>
       print(response)
        let tempArray  = response["items"] as! [[String : Any]]
        let channelId : String = (tempArray[0]["snippet"] as! [String : Any])["channelId"] as! String
        
        // GET Playlist from Channel id service
        let url1 = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=\(channelId)&maxResults=50&key=\(key)"
        
        let response2  = nsdataToJSON(getJSON(url1))
        print(response2)
        channelArray = (response2 as! [String : Any])["items"] as! [[String:Any]]

        tblView.reloadData()
        return channelArray
    }
    func getJSON(_ urlToRequest: String) -> Data{
        
        
        return (try! Data(contentsOf: URL(string: urlToRequest)!))
    }
    
    func nsdataToJSON(_ data: Data) -> Any? {
        
        var responseDict : Any?
        do {
            responseDict =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch let myJSONError {
            print(myJSONError)
        }
 
        return responseDict
    }

   

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        let key = "AIzaSyBL-9jLBoHb_cF7VBcnL643fDX0DFziaeE"
        // let query = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let query1 = textField.text?.replacingOccurrences(of: " ", with:"")
        
        channelArray = getAllChannelsWithKey(key, query: query1!)
        
        textField.text = ""
    
        return true
    }
    //MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let thumbnailImageView : UIImageView = cell.viewWithTag(1) as! UIImageView
        let title : UILabel = cell.viewWithTag(2) as! UILabel
    
        let thumbnailURL : String = (((channelArray[indexPath.row]["snippet"] as! [String:Any])["thumbnails"] as! [String:Any])["high"] as! [String:Any])["url"] as! String
            
    
        
        if !thumbnailURL.isEmpty {
          
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
                
            
                thumbnailImageView.image = UIImage(data: self.getJSON(thumbnailURL))
               
            })
            
            
            
        }
        
      
        
    
        title.text = ((channelArray[indexPath.row])["snippet"] as! [String:Any])["title"] as! String


       
        return cell
    }
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segVCToVideoPlayVC", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segVCToVideoPlayVC" {
            print("hello")
        }
        
    }


}

