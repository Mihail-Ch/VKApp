//
//  FriendsPhotoViewController.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit
import Kingfisher


class FriendsPhotoViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    var friendId: Int = 0
    var photo: [Photo]?
    lazy var vkApi = VKApi()
    lazy var repository = Repository()
    
   
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromCache()
        
        vkApi.getFriendsPhoto(ownerId: friendId) { [weak self] in
           self?.loadFromCache()
        }
    }
    
    //MARK: - Realm
    
    private func loadFromCache() {
        photo = repository.fetchPhotos(ownerId: friendId)
        collectionView?.reloadData()
    }

    @IBAction func unwindToShowPhoto(_ unwindSegue: UIStoryboardSegue) { }


// MARK: - UICollectionViewDelegateFlowLayout
/*enum  Layout {
    static let columns = 2
    static let cellHeight: CGFloat = 150
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let isBigCell = (indexPath.row + 1) % (Layout.columns + 1) == 0
    let width = isBigCell ? collectionView.frame.width : collectionView.frame.width / 2
    
    return CGSize(width: width, height: Layout.cellHeight)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
}*/

}

//MARK: - DataSource

extension FriendsPhotoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photo!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let photos = photo![indexPath.row]
        let url = URL(string: photos.imageUrl)
        cell.configure(with: url)
        return cell
    }
}

//MARK: - Delegate

extension FriendsPhotoViewController: UICollectionViewDelegate { }


