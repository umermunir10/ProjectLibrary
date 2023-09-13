//  SearchViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 11/08/2023.

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchPageViewContainer: UIView!
    
    var tabsData = Utilities.getLibraryHeaderTitles()
    
    lazy var vcList: [UIViewController] = {
        let magazineVC = SearchMagazineViewController.instantiate(storyboard: .Main)
        magazineVC.magazineSelecionDelegate = self
        let bookVC = SearchBookViewController.instantiate(storyboard: .Main)
        bookVC.bookSelectionDelegate = self
        return [magazineVC, bookVC]
    }()
    
    var pageViewController: UIPageViewController!
    var pageInPrevious: Int = 0
    var didLoadViews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchView.layer.cornerRadius = 6
        registerCell()
        goToSearchMagazineVC()
        initPageVC()
        setPageViewFrame()
       
    }
    
    func registerCell() {
        
        self.searchCollectionView.register(UINib(nibName: "PageTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageTitleCollectionViewCell")
    }
    
    func initPageVC() {
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        //self.pageViewController.delegate = self
        //self.pageViewController.dataSource = self
        self.pageViewController.view.backgroundColor = .clear
        if let firstVC = vcList.first {
            self.pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
    }
    
    func setPageViewFrame() {
        
        self.pageViewController.view.frame = self.searchPageViewContainer.frame
    }
    
    func goToSearchBookVC() {
        
        let vc = SearchBookViewController.instantiate(storyboard: .Main)
       // self.navigationController?.pushViewController(vc, animated: true)
        displayContentViewController(vc)
    }
    
    func goToSearchMagazineVC() {
        
        let vc = SearchMagazineViewController.instantiate(storyboard: .Main)
        //self.navigationController?.pushViewController(vc, animated: true)
        displayContentViewController(vc)
    }
    
    func displayContentViewController(_ contentViewController: UIViewController) {
            // Remove existing child view controllers
            for childVC in children {
                childVC.removeFromParent()
                childVC.view.removeFromSuperview()
            }

            // Add the new content view controller as a child
            addChild(contentViewController)
            contentViewController.view.frame = searchPageViewContainer.bounds
            searchPageViewContainer.addSubview(contentViewController.view)
            contentViewController.didMove(toParent: self)
        }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "PageTitleCollectionViewCell", for: indexPath) as! PageTitleCollectionViewCell
        cell.configureCell(tabsData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.pageInPrevious = indexPath.row
        self.pageViewController.setViewControllers([vcList[indexPath.row]], direction: .forward, animated: true, completion: nil)
        for (index, item) in tabsData.enumerated() {
            if index == indexPath.row {
                item.isSelected = true
                goToSearchBookVC()
                //searchPageViewContainer.backgroundColor = UIColor.darkGray
            } else {
                item.isSelected = false
                goToSearchMagazineVC()
                //searchPageViewContainer.backgroundColor = UIColor.black
            }
        }
        self.searchCollectionView.reloadData()
    }
}

extension SearchViewController: MagazineSelectionDelegate {
    func onMagazineSelection(_ magazine: Book) {
        let vc = MagazineDetailsViewController.instantiate(storyboard: .Main)
        vc.magazine = magazine
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: BookSelectionDelegate {
    func onBookSelection(_ book: Book) {
        let vc = BookDetailsViewController.instantiate(storyboard: .Main)
        vc.book = book
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
