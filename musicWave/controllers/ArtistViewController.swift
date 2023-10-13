//
//  ArtistViewController.swift
//  musicWave
//
//  Created by Eddy on 12/10/2023.
//

import UIKit

class ArtistViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var albumArray : [Album] = []
    
    var artist : Artist?
    
   
    @IBOutlet weak var albumCollection: UICollectionView!
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumCollection.delegate = self
        albumCollection.dataSource = self
        self.title = "Artiste"
        if let artistSelect = artist {
                    let URLStr = artistSelect.pictureMedium
                    if let url = URL(string: URLStr), let data = try? Data(contentsOf: url) {
                        artistImage.image = UIImage(data: data)
                    }
                
                    self.artistLabel.text = artistSelect.name
                    fetchAlbumFromAPI(id: artistSelect.id)
                    
                }
    }
   
    
    func fetchAlbumFromAPI(id : Int) {
              
              if let url = URL(string: "https://api.deezer.com/artist/\(id)/albums") {
                  let session = URLSession.shared
                  
                  let task = session.dataTask(with: url) {
                      (data, response, error) in
                      if let error = error {
                          self.albumArray = []
                          print(error)
                          
                      } else if let data = data {
                          print(data)
                          let json = try? JSONSerialization.jsonObject(with: data, options: [])
                          self.mapAlbum(json : json as AnyObject)
                          print(self.albumArray)
                          
                      }
                      
                      DispatchQueue.main.async {
                          self.albumCollection.reloadData()
                      }
                      
                  }
                 
                  task.resume()
              }
          }
          func mapAlbum(json: AnyObject) {
              if  let data = json["data"] as? [[String : AnyObject]] {
                  for item in data {
                      if let album = Album(json: item){
                          self.albumArray.append(album)
                          
                      }
                  }
              } else {
                  print("Invalid JSON format: 'data' is not an array or JSON is not in the expected format.")
              }
              
              
              
             
          }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("section")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count")

        return self.albumArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collection")

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionView", for: indexPath) as? AlbumCollectionViewCell
        let dataItem = self.albumArray[indexPath.item]

        cell?.configure(with: dataItem)
        
        return cell!
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       print("size")

        let noOfCellsInRow: CGFloat = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpacing = flowLayout.minimumInteritemSpacing * (noOfCellsInRow - 1)
        let itemWidth = (collectionView.bounds.width - totalSpacing) / noOfCellsInRow
        let itemHeight = itemWidth + 50

        return CGSize(width: itemWidth, height: itemHeight)
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print("inter")

        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
            let albulm = self.albumArray[indexPath.item]
        
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumVIewController") as? TrackListViewController {
            vc.album = albulm
            
            
            //let navigationController = UINavigationController(rootViewController: vc)
            self.navigationController?.pushViewController(vc, animated: true)
            
            // self.navigationController?.present(vc, animated: true, completion: nil)
        }
        
            
        }
    

}
