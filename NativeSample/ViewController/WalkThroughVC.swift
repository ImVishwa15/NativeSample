//
//  ViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class WalkThroughCell: UICollectionViewCell {
    
    // imageView
    @IBOutlet weak var imageView: UIImageView!
    
    // label
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:  Identifier
    static var identifier: String {
        return "WalkThroughCell"
    }
    
    // MARK:  cell configuration
    var walkThrough: WalkThrough! {
        didSet {
            self.titleLabel.text = walkThrough.title
            self.imageView.image = walkThrough.image
        }
    }
    
    // MARK:  View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// used for button action
private enum WalkThroughButtons: Int {
    case signIn = 1
    case signUp
}

class WalkThroughVC: UIViewController {
    
    // pageControl
    @IBOutlet weak var pageControl: UIPageControl!{
        didSet {
            pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
        }
    }
    
    // collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    // int
    var currentIndex = 0
    
    var walkThroughs = [WalkThrough]()
    
    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        initialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.collectionView.reloadData()
    }
    
    // MARK:  Buttons Action
    @IBAction func walkthroughButtonAction(_ sender: UIButton) {
        if let buttonType = WalkThroughButtons(rawValue: sender.tag) {
            switch buttonType {
            case .signIn:
                self.navigationController?.pushViewController(signInVC(), animated: true)
            case .signUp:
                self.navigationController?.pushViewController(signUpVC(), animated: true)
            }
        }
    }
    
    // MARK:  Page Control Method
    private func updatePageControlDots() {
        DispatchQueue.main.async {
            for i in 0 ..< self.pageControl.subviews.count {
                let dot: UIView = self.pageControl.subviews[i]
                if i == self.pageControl?.currentPage {
                    dot.backgroundColor = .white
                    dot.layer.cornerRadius = dot.frame.size.height / 2
                }
                else {
                    dot.backgroundColor = .gray
                    dot.layer.cornerRadius = dot.frame.size.height / 2
                    dot.layer.borderColor = UIColor.clear.cgColor
                    dot.layer.borderWidth = 1
                }
            }
        }
    }
    
    // MARK:  UIPageControl Action
    @objc private func pageChanged(_ pageControl: UIPageControl) {
        // Move to Right
        if currentIndex < self.walkThroughs.count && pageControl.currentPage > currentIndex {
            self.currentIndex += 1
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .right, animated: true)
            // Move to Left
        } else if currentIndex > 0 {
            self.currentIndex -= 1
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .left, animated: true)
        }
        self.pageControl.currentPage = self.currentIndex
        updatePageControlDots()
    }
    
    // MARK:  UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(self.collectionView.contentOffset.x) / Int(self.collectionView.frame.size.width)
        self.currentIndex = self.pageControl.currentPage
        self.updatePageControlDots()
    }
    
    // MARK:  Initialization
    private func initialization() {
        
        self.walkThroughs = WalkThrough.create()
        self.view.backgroundColor = CustomColor.customGray
        
        func setUpPageControl() {
            self.pageControl.isUserInteractionEnabled = true
            self.pageControl.numberOfPages = self.walkThroughs.count
            self.pageControl.currentPage = 0
            updatePageControlDots()
        }
        func setUpCollectionView() {
            self.collectionView.bounces = false
            self.collectionView.clipsToBounds = true
            self.collectionView.isPagingEnabled = true
            self.collectionView.backgroundColor = .clear
            self.collectionView.showsVerticalScrollIndicator = false
            self.collectionView.showsHorizontalScrollIndicator = false
            self.collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            self.collectionViewFlowLayout.minimumInteritemSpacing = 0.0
            self.collectionViewFlowLayout.scrollDirection = .horizontal
            self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.isUserInteractionEnabled = true
        }
        setUpPageControl()
        setUpCollectionView()
    }
    
}

extension WalkThroughVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // MARK:  UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.walkThroughs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkThroughCell.identifier, for: indexPath) as? WalkThroughCell else {
            fatalError("index path is incorrect")
        }
        cell.backgroundColor = UIColor.clear
        cell.walkThrough = walkThroughs[indexPath.row]
        return cell
    }
    
    // MARK:  UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.collectionView.frame.size.width, height:self.collectionView.frame.size.height)
    }
    
    // MARK:  UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
