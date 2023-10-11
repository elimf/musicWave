//
//  HomeViewController.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
}

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var tracks: [Track] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
        let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                let url = URL(string: "http://api.deezer.com/chart/0/tracks")!
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                            if let data = json as? [String: AnyObject] {
                                
                                if let items = data["data"] as? [[String: AnyObject]] {
                                    for item in items {
                                        if let track = Track(json: item) {
                                            self.tracks.append(track)
                                            print(track.title)
                                            print(track.album.coverSmall)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                      //  self.tableView.reloadData()
                    }
                }
                task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionView", for: indexPath) as? homeCollectionViewCell

            let dataItem = self.tracks[indexPath.item]
            //cell.titleLabel.text = dataItem.title
        
        cell!.trackLabel.text = dataItem.title
        
        return cell!
    }

}
