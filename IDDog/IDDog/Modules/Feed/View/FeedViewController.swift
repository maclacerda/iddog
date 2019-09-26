//
//  FeedViewController.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak fileprivate var collectionView: UICollectionView!
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
      self.setupView()
    }
  }
  
  fileprivate var currenctCategorie: FeedCategories = .husky
  
  fileprivate var viewModel: FeedViewModel!
  fileprivate var datasource: FeedDatasource = FeedDatasource()
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.viewModel = FeedViewModel(with: self, datasource: datasource)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.viewModel = FeedViewModel(with: self, datasource: datasource)
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupCollectionView()

    self.loadFeed()
  }

  // MARK: - Private methods

  fileprivate func setupView() {
    // Handler the user interaction in screen
    self.view.isUserInteractionEnabled = (state == .normal)

    switch state {
    case .normal:
      activityIndicator.stopAnimating()
      collectionView.isHidden = false
      collectionView.reloadData()
      
    case .loading:
      collectionView.isHidden = true
      activityIndicator.startAnimating()

    case .error:
      collectionView.isHidden = true
      activityIndicator.stopAnimating()
    }
  }
  
  fileprivate func setupCollectionView() {
    collectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCell")
    
    collectionView.dataSource = datasource
    
    // Flow layout
    let width = view.frame.size.width
    let padding: CGFloat = 32

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: (width - padding) * 0.35, height: 100)
    flowLayout.minimumLineSpacing = 4
    flowLayout.minimumInteritemSpacing = 4
    flowLayout.scrollDirection = .vertical
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    collectionView.collectionViewLayout = flowLayout
  }
  
  fileprivate func makeExpandedImage(with image: String) {
    let expandedView = ExpandedImageView(frame: self.view.bounds)
    
    expandedView.dismissOnTap = true

    UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
      self.view.addSubview(expandedView)
    }, completion: nil)

    DispatchQueue.main.async {
      expandedView.show(with: image)
    }
  }
  
  // MARK: - Actions
  
  @IBAction fileprivate func changeCategorieValueChanged(_ sender: UISegmentedControl) {
    var category: FeedCategories = .husky
    
    switch sender.selectedSegmentIndex {
    case 1: category = .hound
    case 2: category = .pug
    case 3: category = .labrador
    default: category = .husky
    }

    self.currenctCategorie = category

    self.state = .loading
    viewModel.fetchFeed(by: category)
  }
  
  fileprivate func loadFeed() {
    self.state = .loading
    viewModel.fetchFeed(currenctCategorie)
  }

}

extension FeedViewController: FeedViewModelDelegate {

  func feedFetchedWithSuccess() {
    self.state = .normal
  }
  
  func feedFetchedWithError(_ error: String) {
    self.state = .error

    self.showErrorMessage(error, withTryAgainButton: true, tryAgainCallback: {
      self.loadFeed()
    })
  }

}

extension FeedViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Show photo in full screen
    let photo = datasource.givePhoto(at: indexPath)
    self.makeExpandedImage(with: photo)
  }
  
}
