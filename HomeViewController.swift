//
//  HomeViewController.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
}

class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var tracks: [Track] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        



        
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
                                            print(track.album.coverMedium)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                      self.collectionView.reloadData()
                    }
                }
                task.resume()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as? homeCollectionViewCell

            let dataItem = self.tracks[indexPath.item]

        cell?.configure(with: dataItem)
        
        return cell!
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow: CGFloat = 3 // Change this to your desired number of items per row
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpacing = flowLayout.minimumInteritemSpacing * (noOfCellsInRow - 1)
        let itemWidth = (collectionView.bounds.width - totalSpacing) / noOfCellsInRow
        let itemHeight = itemWidth + 50 // You can adjust the height as needed

        return CGSize(width: itemWidth, height: itemHeight)
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTrack = self.tracks[indexPath.item]
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "player") as? PlayerViewController {
            vc.track = selectedTrack
            self.present(vc, animated: true, completion: nil)
        }
    }
}
