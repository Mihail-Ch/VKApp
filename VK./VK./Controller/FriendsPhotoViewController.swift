//
//  FriendsPhotoViewController.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class FriendsPhotoViewController: UIViewController {

   
    var photo: User?
    var vkApi = VKApi()
    let session = Session.shared
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//MARK: - DataSource

extension FriendsPhotoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo!.avatar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
       // cell.userPhoto.image = UIImage(named: photo!.avatar[indexPath.row])
        return cell
    }
}

//MARK: - Delegate

extension FriendsPhotoViewController: UICollectionViewDelegate {
    
}


