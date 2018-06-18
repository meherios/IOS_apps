//
//  TableDataViewController.swift
//  
//
//  Created by Meher Jyoti Singh on 4/16/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit
import Alamofire

class TableDataViewController: UITableViewController, VideoModelDelegate {
    

    @IBOutlet var Tableview: UITableView!
    
    var videoArray = [Video]()
    
    var delegate:VideoModelDelegate?
    
    var videos:[Video] = [Video]()
    
    var selectedVideo:Video?
    let model:VideoModel = VideoModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredarray: [Video] = [Video]()
    
    func filteredContentforsearch(searchText: String, scope: String = "All"){
        filteredarray = videos.filter{ (video) in
            return video.videoTitle.contains(searchText)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        model.getFeedVideos()
    
        Tableview.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
       
    }
    
    func dataReady() {
        self.videos = self.model.videoArray
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.width / 240) * 170
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != nil{
            return filteredarray.count
        }
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
    
        let videoThumbnailUrlString = videos[indexPath.row].videoThumbnailUrl
        
        let videoThumbNailUrl = URL(string: videoThumbnailUrlString)
        
        if videoThumbNailUrl != nil {
            let request = URLRequest(url: videoThumbNailUrl!)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    imageView.image = UIImage(data: data!)
                })
            })
            dataTask.resume()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVideo = self.videos[indexPath.row]
        self.performSegue(withIdentifier: "gotoDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! VideoViewController
        detailViewController.selectedVideo = self.selectedVideo
    }

    @IBAction func SignoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
        print("User has Logged Out")
    }
    
}

extension TableDataViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentforsearch(searchText: searchController.searchBar.text!)
    }
}
