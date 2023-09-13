//  LibraryViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 15/08/2023.

import UIKit

protocol LibraryBooksDelegate {
    func openBookFilters()
}
    
class LibraryViewController: UIViewController {
    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var collectionViewTabs: UICollectionView!
    @IBOutlet weak var viewPageContainer: UIView!
    
    var selection = PageTitleCollectionViewCell()
    var magazineSelectionDelegate: MagazineSelectionDelegate?
    var tabsData = Utilities.getLibraryHeaderTitles()
    
    lazy var vcList: [UIViewController] = {
        let magazineVC = LibraryMagazineViewController.instantiate(storyboard: .Main)
        magazineVC.magazineSelectionDelegate = self
        let booksVC = LibraryBookViewController.instantiate(storyboard: .Main)
        booksVC.libraryBooksDelegate = self
        booksVC.bookSelectionDelegate = self
        return [magazineVC, booksVC]
    }()
    
    var pageInPrevious: Int = 0
    var pageViewController: UIPageViewController!
    var didLoadViews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseCells()
        goToLibraryMagazineVC()
        initPageVC()
        setPageViewFrame()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initialiseCells() {
        
        self.collectionViewTabs.register(UINib(nibName: "PageTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageTitleCollectionViewCell")
        
    }
    
    func initPageVC() {
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       // self.pageViewController.dataSource = self
        //self.pageViewController.dataSource = self
        self.pageViewController.view.backgroundColor = .clear
        if let firstVC = vcList.first {
            self.pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
    }
    
    func setPageViewFrame() {
        self.pageViewController.view.frame = self.viewPageContainer.frame
    }
    
//    func goToLibraryBookVC() {
//
//        let vc = LibraryBookViewController.instantiate(storyboard: .Main)
//        // self.navigationController?.pushViewController(vc, animated: true)
//        displayContentViewController(vc)
//    }
//
    func goToLibraryMagazineVC() {

        let vc = LibraryMagazineViewController.instantiate(storyboard: .Main)
        //self.navigationController?.pushViewController(vc, animated: true)
       // displayContentViewController(vc)
    }
//
//    func displayContentViewController(_ contentViewController: UIViewController) {
//        // Remove existing child view controllers
//        for childVC in  children {
//            childVC.removeFromParent()
//            childVC.view.removeFromSuperview()
//        }
//
//        // Add the new content view controller as a child
//        addChild(contentViewController)
//        contentViewController.view.frame = viewPageContainer.bounds
//        viewPageContainer.addSubview(contentViewController.view)
//        // self.navigationController?.pushViewController(contentViewController, animated: true)
//        contentViewController.didMove(toParent: self)
//    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewTabs.dequeueReusableCell(withReuseIdentifier: "PageTitleCollectionViewCell", for: indexPath) as! PageTitleCollectionViewCell
        cell.configureCell(tabsData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       self.pageInPrevious = indexPath.row
        self.pageViewController.setViewControllers([vcList[indexPath.row]], direction: .forward, animated: true, completion: nil)
        for (index, item) in self.tabsData.enumerated() {
            if index == indexPath.row {
                item.isSelected = true
                //goToLibraryBookVC()
            } else  {
                item.isSelected = false
               // goToLibraryMagazineVC()
            }
        }
        self.collectionViewTabs.reloadData()
    }
}

//extension LibraryViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = vcList.firstIndex(of: viewController) else { return nil }
//        var previousIndex = viewControllerIndex - 1
//        if previousIndex == -1 || previousIndex == NSNotFound {
//            previousIndex = 1
//        }
//        return vcList[previousIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = vcList.firstIndex(of: viewController) else { return nil }
//        var nextIndex = viewControllerIndex + 1
//        if nextIndex == 2 || nextIndex == NSNotFound {
//            nextIndex = 0
//        }
//        return vcList[nextIndex]
//    }
//}

// MARK:- BookFiltersDelegate
extension LibraryViewController: LibraryBooksDelegate {
    func openBookFilters() {
        let vc = BookFiltersViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- MagazineSelecctionDelegate
extension LibraryViewController: MagazineSelectionDelegate {
    func onMagazineSelection(_ magazine: Book) {
        let vc = MagazineDetailsViewController.instantiate(storyboard: .Main)
        vc.magazine = magazine
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- BookSelecctionDelegate
extension LibraryViewController: BookSelectionDelegate {
    func onBookSelection(_ book: Book) {
        let vc = BookDetailsViewController.instantiate(storyboard: .Main)
        vc.book = book
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
