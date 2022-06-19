//
//  CustomTabBarViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 23/04/22.
//

import UIKit
import SideMenu

class CustomTabBarViewController: UIViewController , XIBed, PushViewControllerDelegate {
    @IBOutlet weak var tabBarOuterview: UIView!
    @IBOutlet weak var homeStackViewRef: UIStackView!
    @IBOutlet weak var homeImgViewRef: UIImageView!
    @IBOutlet weak var homeLblRef: UILabel!
    
    @IBOutlet weak var consultationStackViewRef: UIStackView!
    @IBOutlet weak var consultationImgViewRef: UIImageView!
    @IBOutlet weak var consultationLblRef: UILabel!
    
    @IBOutlet weak var orderTrackerStackViewRef: UIStackView!
    @IBOutlet weak var orderTrackerImgViewRef: UIImageView!
    @IBOutlet weak var orderTrackerLblRef: UILabel!
    
    @IBOutlet weak var myProfileStackViewRef: UIStackView!
    @IBOutlet weak var myProfileImgViewRef: UIImageView!
    @IBOutlet weak var myProfileLblRef: UILabel!
    
    ///Container View
    @IBOutlet weak var containerView: UIView!
    
    ///Nav Bar
    @IBOutlet weak var navOuterview: UIView!
    @IBOutlet weak var sideMenuBtnRef: UIButton!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var cartBtnRef: UIButton!
    
    
    ///Page Control
    lazy var pageVC: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        return pageVC
    }()
    
    var screenType = 0
    
    var selectedLineColor = UIColor.init(hexString: "007AB8")
    var selectedTextColor = UIColor.black
    var unSelectedTextColor = UIColor.lightGray
    
    
    lazy var VCArr: [UIViewController] = {
        return [
            {
                let vc = HomeViewController.instantiate()
                vc.pushDelegate = self
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = ConsultationMainViewController.instantiate()
                vc.pushDelegate = self
                //vc.user = user
                //vc.gDrive = gDrive
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = OrderTrackVC.instantiate()
                vc.pushDelegate = self
                //vc.user = user
                //vc.gDrive = gDrive
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = ProfileVC.instantiate()
                vc.pushDelegate = self
                //vc.user = user
                //vc.gDrive = gDrive
                return UINavigationController(rootViewController: vc)
            }()
        ]
    }()
    
    var currentIndex: Int?
    private var pendingIndex: Int?
    weak var pushDelegate: PushViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupCornerShadow()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}

//MARK: - Setup
extension CustomTabBarViewController {
    func setupUI() {
        self.pushDelegate = self
        self.setupPageControl()
        
        if screenType == 0 {
            
            homeLblRef.textColor = UIColor.green
            homeImgViewRef.tintColor = UIColor.green
            
            consultationLblRef.textColor = UIColor.lightGray
            consultationImgViewRef.tintColor = UIColor.lightGray
            
            orderTrackerLblRef.textColor = UIColor.lightGray
            orderTrackerImgViewRef.tintColor = UIColor.lightGray
            
            myProfileLblRef.textColor = UIColor.lightGray
            myProfileImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "Home"
            
            if let firstVC = self.VCArr.first {
                self.pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            }
            
        } else if screenType == 1 {
            
            consultationLblRef.textColor = UIColor.green
            consultationImgViewRef.tintColor = UIColor.green
            
            homeLblRef.textColor = UIColor.lightGray
            homeImgViewRef.tintColor = UIColor.lightGray
            
            orderTrackerLblRef.textColor = UIColor.lightGray
            orderTrackerImgViewRef.tintColor = UIColor.lightGray
            
            myProfileLblRef.textColor = UIColor.lightGray
            myProfileImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "Consultation"
            
            let firstVC = self.VCArr[1]
            self.pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            
            
        } else if screenType == 2 {
            
            orderTrackerLblRef.textColor = UIColor.green
            orderTrackerImgViewRef.tintColor = UIColor.green
            
            homeLblRef.textColor = UIColor.lightGray
            homeImgViewRef.tintColor = UIColor.lightGray
            
            consultationLblRef.textColor = UIColor.lightGray
            consultationImgViewRef.tintColor = UIColor.lightGray
            
            myProfileLblRef.textColor = UIColor.lightGray
            myProfileImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "Order Tracker"
            
            let firstVC = self.VCArr[2]
            self.pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            
            
        } else if screenType == 3 {
            
            myProfileLblRef.textColor = UIColor.green
            myProfileImgViewRef.tintColor = UIColor.green
            
            homeLblRef.textColor = UIColor.lightGray
            homeImgViewRef.tintColor = UIColor.lightGray
            
            consultationLblRef.textColor = UIColor.lightGray
            consultationImgViewRef.tintColor = UIColor.lightGray
            
            orderTrackerLblRef.textColor = UIColor.lightGray
            orderTrackerImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "My Profile"
            
            let firstVC = self.VCArr[3]
//            self.pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            self.navigationController?.pushViewController(firstVC, animated: true)
            
        }
        
        let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(homeBtnTap))
        homeTapGesture.cancelsTouchesInView = false
        homeStackViewRef.addGestureRecognizer(homeTapGesture)
        
        let consultationTapGesture = UITapGestureRecognizer(target: self, action: #selector(consultationBtnTap))
        consultationTapGesture.cancelsTouchesInView = false
        consultationStackViewRef.addGestureRecognizer(consultationTapGesture)
        
        let orderTrackerTapGesture = UITapGestureRecognizer(target: self, action: #selector(orderTrackerBtnTap))
        orderTrackerTapGesture.cancelsTouchesInView = false
        orderTrackerStackViewRef.addGestureRecognizer(orderTrackerTapGesture)
        
        let myProfileTapGesture = UITapGestureRecognizer(target: self, action: #selector(myProfileBtnTap))
        myProfileTapGesture.cancelsTouchesInView = false
        myProfileStackViewRef.addGestureRecognizer(myProfileTapGesture)
    }
    
    func setupCornerShadow() {
        
        navOuterview.dropShadow()
        tabBarOuterview.dropShadow()
        
    }
    
    func setupPageControl() {
        
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear
        
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
        for view in self.pageVC.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
                scrollView.isPagingEnabled = true
                scrollView.isScrollEnabled = true
            }
        }
        
        containerView.addSubview(pageVC.view)
        self.addChild(pageVC)
        
        
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -10),
            pageVC.view.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            pageVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            pageVC.view.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0)
        ])
        pageVC.didMove(toParent: self)
        
    }
    
    
    
}


//MARK: - Action
extension CustomTabBarViewController {
    
    @IBAction func sideMenuBtnTap(_ sender: UIButton) {
        let vc = CustomSideMenuViewController.instantiate()
        
        let menu = SideMenuNavigationController(rootViewController:vc)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = view.frame.width - 80
        present(menu, animated: true, completion: nil)
        
    }
    
    @IBAction func cartBtnTap(_ sender: UIButton) {
        let vc = CartDetails.instantiate()
        pushDelegate?.pushViewController(vc: vc)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func homeBtnTap() {
        homeLblRef.textColor = UIColor.green
        homeImgViewRef.tintColor = UIColor.green
        
        consultationLblRef.textColor = UIColor.lightGray
        consultationImgViewRef.tintColor = UIColor.lightGray
        
        orderTrackerLblRef.textColor = UIColor.lightGray
        orderTrackerImgViewRef.tintColor = UIColor.lightGray
        
        myProfileLblRef.textColor = UIColor.lightGray
        myProfileImgViewRef.tintColor = UIColor.lightGray
        
        navTitleLblRef.text = "Home"
        
        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
        if pageIndex == 1{
            pageIndex = pageIndex! - 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        } else if pageIndex == 2{
            pageIndex = pageIndex! - 2
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        } else if pageIndex == 3{
            pageIndex = pageIndex! - 3
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    @objc func consultationBtnTap() {
        consultationLblRef.textColor = UIColor.green
        consultationImgViewRef.tintColor = UIColor.green
        
        homeLblRef.textColor = UIColor.lightGray
        homeImgViewRef.tintColor = UIColor.lightGray
        
        orderTrackerLblRef.textColor = UIColor.lightGray
        orderTrackerImgViewRef.tintColor = UIColor.lightGray
        
        myProfileLblRef.textColor = UIColor.lightGray
        myProfileImgViewRef.tintColor = UIColor.lightGray
        
        navTitleLblRef.text = "Consultation"
        
        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
        if pageIndex == 0{
            pageIndex = pageIndex! + 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        } else if pageIndex == 2{
            pageIndex = pageIndex! - 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        } else if pageIndex == 3{
            pageIndex = pageIndex! - 2
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        }
        
        
        
    }
    
    @objc func orderTrackerBtnTap() {
        orderTrackerLblRef.textColor = UIColor.green
        orderTrackerImgViewRef.tintColor = UIColor.green
        
        homeLblRef.textColor = UIColor.lightGray
        homeImgViewRef.tintColor = UIColor.lightGray
        
        consultationLblRef.textColor = UIColor.lightGray
        consultationImgViewRef.tintColor = UIColor.lightGray
        
        myProfileLblRef.textColor = UIColor.lightGray
        myProfileImgViewRef.tintColor = UIColor.lightGray
        
        navTitleLblRef.text = "Order Tracker"
        
        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
        if pageIndex == 0{
            pageIndex = pageIndex! + 2
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        } else if pageIndex == 1{
            pageIndex = pageIndex! + 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        } else if pageIndex == 3{
            pageIndex = pageIndex! - 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    @objc func myProfileBtnTap() {
        myProfileLblRef.textColor = UIColor.green
        myProfileImgViewRef.tintColor = UIColor.green
        
        homeLblRef.textColor = UIColor.lightGray
        homeImgViewRef.tintColor = UIColor.lightGray
        
        consultationLblRef.textColor = UIColor.lightGray
        consultationImgViewRef.tintColor = UIColor.lightGray
        
        orderTrackerLblRef.textColor = UIColor.lightGray
        orderTrackerImgViewRef.tintColor = UIColor.lightGray
        
        navTitleLblRef.text = "My Profile"
        
        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
        if pageIndex == 0{
            pageIndex = pageIndex! + 3
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        } else if pageIndex == 1{
            pageIndex = pageIndex! + 2
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        } else if pageIndex == 2{
            pageIndex = pageIndex! + 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        
    }
    
}
//MARK: - Page Control
extension CustomTabBarViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //        let currentIndex = self.VCArr.firstIndex(of: viewController)!
        //        let previousIndex = currentIndex - 1
        //        return (previousIndex == -1) ? nil : self.VCArr[previousIndex]
        
        let currentIndex = VCArr.firstIndex(of: viewController)!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % VCArr.count)
        return VCArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //        let currentIndex = self.VCArr.firstIndex(of: viewController)!
        //        let nextIndex = currentIndex + 1
        //        return (nextIndex == self.VCArr.count) ? nil : self.VCArr[nextIndex]
        
        let currentIndex = VCArr.firstIndex(of: viewController)!
        if currentIndex == VCArr.count-1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % VCArr.count)
        return VCArr[nextIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        //        pendingIndex = VCArr.firstIndex(of: pendingViewControllers.first!)!
        //        updateControlView()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            completed else { return }
        
        pendingIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?.first!)!)!
        updateControlView()
        
    }
    
    private func updateControlView() {
        
        if pendingIndex == 0 {
            
            homeLblRef.textColor = UIColor.green
            homeImgViewRef.tintColor = UIColor.green
            
            consultationLblRef.textColor = UIColor.lightGray
            consultationImgViewRef.tintColor = UIColor.lightGray
            
            orderTrackerLblRef.textColor = UIColor.lightGray
            orderTrackerImgViewRef.tintColor = UIColor.lightGray
            
            myProfileLblRef.textColor = UIColor.lightGray
            myProfileImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "Home"
            
        } else if pendingIndex == 1 {
            
            consultationLblRef.textColor = UIColor.green
            consultationImgViewRef.tintColor = UIColor.green
            
            homeLblRef.textColor = UIColor.lightGray
            homeImgViewRef.tintColor = UIColor.lightGray
            
            orderTrackerLblRef.textColor = UIColor.lightGray
            orderTrackerImgViewRef.tintColor = UIColor.lightGray
            
            myProfileLblRef.textColor = UIColor.lightGray
            myProfileImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "Consultation"
            
        } else if pendingIndex == 2 {
            
            orderTrackerLblRef.textColor = UIColor.green
            orderTrackerImgViewRef.tintColor = UIColor.green
            
            homeLblRef.textColor = UIColor.lightGray
            homeImgViewRef.tintColor = UIColor.lightGray
            
            consultationLblRef.textColor = UIColor.lightGray
            consultationImgViewRef.tintColor = UIColor.lightGray
            
            myProfileLblRef.textColor = UIColor.lightGray
            myProfileImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "Order Tracker"
            
        } else if pendingIndex == 3 {
            
            myProfileLblRef.textColor = UIColor.green
            myProfileImgViewRef.tintColor = UIColor.green
            
            homeLblRef.textColor = UIColor.lightGray
            homeImgViewRef.tintColor = UIColor.lightGray
            
            consultationLblRef.textColor = UIColor.lightGray
            consultationImgViewRef.tintColor = UIColor.lightGray
            
            orderTrackerLblRef.textColor = UIColor.lightGray
            orderTrackerImgViewRef.tintColor = UIColor.lightGray
            
            navTitleLblRef.text = "My Profile"
            
        }
        
        
    }
    
    
}


