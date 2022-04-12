//
//  ViewController.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit

class HomePageVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var tracks = [Track]()
    
    var term:String = "sunflower"
    var page = 1
    var searching = false
    var endOfPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        self.search()
        
    }
    
    
    private func search(){
        
        Spinner.start()
        self.searching = true
        NetworkEngine.request(endpoint: ITunesEndpoint.search(term: self.term, page: self.page), completion: {(result:Result<ITunesResponse,Error>) in
            
            self.searching = false
            switch result{
                case .success(let res):
                    print(res)
                    
                    self.tracks += res.results
                    if(res.resultCount == 0){
                        self.endOfPage = true
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        Spinner.stop()
                    }
                    
                case .failure(let error):
                    print(error)
                    self.endOfPage = true
                    DispatchQueue.main.async {
                        Spinner.stop()
                    }
            }

        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? DetailPageVC
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let track = tracks[indexPath.row]
        vc?.track = track
        
    }
    
    
    @objc func endEditing() {
        view.endEditing(true)
    }


}


extension HomePageVC:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
        self.page = 1
        self.endOfPage = false
        self.tracks = []
        if let term = searchBar.text{
            self.term = term
            search()
        }
    }
    
}


extension HomePageVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTVC", for: indexPath) as? TrackTVC else {
            return UITableViewCell()
        }
        
        let track = tracks[indexPath.row]
        cell.setTVC(track: track)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(searching || endOfPage){
            return
        }
        
        if(indexPath.row == (tracks.count) - 1){
            page += 1
            self.search()
        }
    }
    
}

