import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var seachField: UITextField!
    
    @IBOutlet weak var artistCollection: UICollectionView!
    
    var artistArray: [Artist] = []
    
    //Define the structure
    let infoMessage: UILabel = UILabel (frame: CGRect(x: 0, y: 0, width: 150, height: 100))
    
    //Define divers message
    let messageNotFound = "Aucun résultat trouver"
    let messageError =  "Erreur lors de la récupération des artiste"
    let messageFind = "Rechercher un artiste"
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "Recherche"
        //COllection define
        artistCollection.dataSource = self
        artistCollection.delegate = self
        
        
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
                DispatchQueue.main.async {
                  self.artistCollection.reloadData()
                }
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
                print(self.artistArray)
                DispatchQueue.main.async {
                  self.artistCollection.reloadData()
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
       
    }
    
    private func handleLabel (message : String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.infoMessage.text = message
        }}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCollectionViewCell", for: indexPath) as? ArtistCollectionViewCell

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionView", for: indexPath) as? ArtistCollectionViewCell
        let dataItem = self.artistArray[indexPath.item]

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
            print("deee")
            let artist = self.artistArray[indexPath.item]
            
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArtistVIewController") as? ArtistViewController {
            vc.artist = artist
            

            //let navigationController = UINavigationController(rootViewController: vc)
            self.navigationController?.pushViewController(vc, animated: true)

           // self.navigationController?.present(vc, animated: true, completion: nil)

        }
        }
}
