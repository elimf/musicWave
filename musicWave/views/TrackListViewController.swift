//
//  TrackListViewController.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 12/10/2023.
//

import UIKit

class TrackListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
                      
    

    @IBOutlet weak var tableTrack: UITableView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    var album : Album?
    var trackArray : [TrackList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album"
        tableTrack.delegate = self
        tableTrack.dataSource = self
        print("------------------------------------------------------------------------------")
        if let albumSelect = album {
            let URLStr = albumSelect.coverBig
                    if let url = URL(string: URLStr), let data = try? Data(contentsOf: url) {
                        albumImage.image = UIImage(data: data)
                    }
                
            self.albumLabel.text = albumSelect.title
            fetchTrackFromAlbum(id: albumSelect.id)
                    
                }
        
        
    }
    
    func fetchTrackFromAlbum(id : Int) {
              
              if let url = URL(string: "https://api.deezer.com/album/\(id)/tracks") {
                  let session = URLSession.shared
                  
                  let task = session.dataTask(with: url) {
                      (data, response, error) in
                      if let error = error {
                          self.trackArray = []
                          print(error)
                          
                      } else if let data = data {
                          print(data)
                          let json = try? JSONSerialization.jsonObject(with: data, options: [])
                          self.mapAlbum(json : json as AnyObject)
                      }
                      
                      DispatchQueue.main.async {
                          self.tableTrack.reloadData()
                      }
                      
                  }
                 
                  task.resume()
              }
          }
           func mapAlbum(json: AnyObject) {
              if  let data = json["data"] as? [[String : AnyObject]] {
                  for item in data {
                      if let album = TrackList(json: item){
                          self.trackArray.append(album)

                          print(item)
                      }
                  }
              } else {
                  print("Invalid JSON format: 'data' is not an array or JSON is not in the expected format.")
              }
              
          }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return trackArray.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! trackTableViewCell
        let track = trackArray[indexPath.row]
        cell.configure(with: track)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrack = trackArray[indexPath.row]
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "player") as? PlayerViewController {
            vc.trackList = selectedTrack
            self.present(vc, animated: true, completion: nil)
        }
    }


}
