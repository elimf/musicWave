//
//  SearchViewController.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import UIKit

class SearchViewController: UIViewController {
    

    @IBOutlet weak var seachField: UITextField!
    
    @IBOutlet weak var collection: UICollectionView!
    var artistArray: [Any] = []
    
    //Define the structure
    let infoMessage: UILabel = UILabel (frame: CGRect(x: 0, y: 0, width: 150, height: 100))
    
    //Define divers message
    let messageNotFound = "Aucun résultat trouver"
    let messageError =  "Erreur lors de la récupération des artiste"
    let messageFind = "Rechercher un artiste"
    override func viewDidLoad() {
        super.viewDidLoad()
        seachField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        //Definine the label for message
        self.infoMessage.textColor = UIColor.gray
        self.infoMessage.center = self.view.center
        //Init with a message
        self.handleLabel(message: messageFind)
        self.view.addSubview(self.infoMessage)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.artistArray = []
        if let text = textField.text {
            if text.isEmpty{
                self.handleLabel(message: messageFind)
                return
            }
            fetchDataFromAPI(search : text)
        }
    }
    
    
    
    func fetchDataFromAPI(search : String) {
        
        if let url = URL(string: "https://api.deezer.com/search/artist?q=" + search) {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if let error = error {
                    self.artistArray = []
                    self.handleLabel(message: "Erreur lors de la récupération des artiste")
                } else if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    self.mapArtist(json : json as AnyObject)
                    
                }
               
            }
            task.resume()
        }
    }
    
    func mapArtist(json: AnyObject) {
        if  let data = json["data"] as? [[String : AnyObject]] {
            for item in data {
                if let artist = Artist(json: item){
                    self.artistArray.append(artist)
                }
            }
        } else {
            print("Invalid JSON format: 'data' is not an array or JSON is not in the expected format.")
        }
        if self.artistArray.isEmpty{
            self.handleLabel(message: "Auncun résultat trouver")
        }else{
            self.handleLabel(message: "")
            
        }
        print(artistArray)
    }
    
    private func handleLabel (message : String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //self.collection.isHidden = true
            self.infoMessage.text = message
        }}
    

}
