//
//  HomeVC.swift
//  HealthCard
//
//  Created by Viral on 03/04/22.
//

import UIKit

class HomeVC: UIViewController , PushViewControllerDelegate, XIBed, presentViewControllersDelegate {
    func present(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var containerView: UIView!
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



    


    ///Container View
    
    ///Page Control
    lazy var pageVC: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        return pageVC
    }()
    
    lazy var VCArr: [UIViewController] = {
        return [
            {
                let vc = HomeViewController.instantiate()
                //vc.pushDelegate = self
                //vc.dashboardNavigationStateDelegate = self
                //vc.presentDelegate = self
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = HomeViewController.instantiate()
//                vc.pushDelegate = self
//                vc.presentDelegate = self
//                vc.dashboardNavigationStateDelegate = self
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = HomeViewController.instantiate()
//                vc.pushDelegate = self
//                vc.dashboardNavigationStateDelegate = self
//                vc.presentDelegate = self
//                vc.screenType = 1
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = HomeViewController.instantiate()
//                vc.pushDelegate = self
//                vc.dashboardNavigationStateDelegate = self
//                vc.presentDelegate = self
//                vc.modalPresentationCapturesStatusBarAppearance = true
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = HomeViewController.instantiate()
//                vc.pushDelegate = self
//                vc.dashboardNavigationStateDelegate = self
//                vc.screenType = insideScreenType
                return UINavigationController(rootViewController: vc)
            }()
            
        ]
    }()
    
    var screenType = 2
    var insideScreenType = 0
    var currentIndex: Int?
    private var pendingIndex: Int?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupCornerAndShadow()
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
extension HomeVC {
    
    func setupUI() {
            
        
       /* if screenType == 0 {
            bodyLblRef.textColor = Environment.GlobarlUrls.bodySelectedColor
            bodyImgViewRef.image = UIImage(named: "BodySelectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
            if let firstVC = VCArr.first {
                pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            }
        } else if screenType == 1 {
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.mindSelectedColor
            mindImgViewRef.image = UIImage(named: "MindSelectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
            let firstVC = VCArr[1] //{
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        else if screenType == 2 {
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
            todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
            let firstVC = VCArr[2] //{
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            //}
        } else if screenType == 3 {
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.sleepSelectedColor
            sleepImgViewRef.image = UIImage(named: "SleepSelectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
            let firstVC = VCArr[3] //{
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
        } else if screenType == 4 {
            
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.journalSelectedColor
            journalImgViewRef.image = UIImage(named: "JournalSelectedIcon")
            
            
            if let firstVC = VCArr.last {
                pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            }
        }
        
        progressPercentLblRef.text = "\(Int(progressViewRef.progress * 100)) %" */
        if let firstVC = VCArr.first {
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        setupPageControl()
        
       /* let bodyTabTapGesture = UITapGestureRecognizer(target: self, action: #selector(bodyTabBtnTap))
        bodyTabTapGesture.cancelsTouchesInView = false
        bodyStackViewRef.addGestureRecognizer(bodyTabTapGesture)
        
        let mindTabTapGesture = UITapGestureRecognizer(target: self, action: #selector(mindTabBtnTap))
        mindTabTapGesture.cancelsTouchesInView = false
        mindStackViewRef.addGestureRecognizer(mindTabTapGesture)
        
        let todayTabTapGesture = UITapGestureRecognizer(target: self, action: #selector(todayTabBtnTap))
        todayTabTapGesture.cancelsTouchesInView = false
        todayStackViewRef.addGestureRecognizer(todayTabTapGesture)
        
        let sleepTabTapGesture = UITapGestureRecognizer(target: self, action: #selector(sleepTabBtnTap))
        sleepTabTapGesture.cancelsTouchesInView = false
        sleepStackViewRef.addGestureRecognizer(sleepTabTapGesture)
        
        let journalTabTapGesture = UITapGestureRecognizer(target: self, action: #selector(journalTabBtnTap))
        journalTabTapGesture.cancelsTouchesInView = false
        journalStackViewRef.addGestureRecognizer(journalTabTapGesture)
        
        
        
        if isPlaceHolderScreen {
            if infoPlaceHolderIndex == 0 {
                
                bodyLblRef.textColor = Environment.GlobarlUrls.bodySelectedColor
                bodyImgViewRef.image = UIImage(named: "BodySelectedIcon")
                
                mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
                mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
                
                todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
                todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
                
                sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
                sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
                
                journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
                journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
                
            }
        } else {
            //self.updateControlView()
            
        } */

    }
    
    func setupCornerAndShadow() {
        //tabViewRef.layer.cornerRadius = 14
        
        
    }
    

    

    
    func setupPageControl() {
        
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear
        
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
        for view in self.pageVC.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
                //scrollView.isPagingEnabled = true
                scrollView.isScrollEnabled = false
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

//MARK: - Button Action
//extension ViewController {
//    @objc func bodyTabBtnTap() {
//        bodyLblRef.textColor = Environment.GlobarlUrls.bodySelectedColor
//        bodyImgViewRef.image = UIImage(named: "BodySelectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        if isPlaceHolderScreen == true {
//            infoPlaceHolderIndex = 0
//
//            bodyDownArrowAnimationViewRef.isHidden = false
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = true
//
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: "bodt-onb")
//            infoPlaceHolderTitleRef.text = "Body"
//            infoPlaceHolderDescRef.text = "A library of smashing workouts for your body including HIIT, Calisthenics, Yoga flows and MMA!"
//            infoPlaceHolderPageDotRef.image = UIImage(named: "firstPageDotIcon")
//
//        }
//        if isPlaceHolderScreen == false {
//        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
//        if pageIndex == 1{
//            pageIndex = pageIndex! - 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        }
//        else if pageIndex == 2 {
//            pageIndex = pageIndex! - 2
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        } else if pageIndex == 3 {
//            pageIndex = pageIndex! - 3
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        } else if pageIndex == 4 {
//            pageIndex = pageIndex! - 4
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        }
//        }
//    }
//
//    @objc func mindTabBtnTap() {
//
//        bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.mindSelectedColor
//        mindImgViewRef.image = UIImage(named: "MindSelectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        if isPlaceHolderScreen == true {
//            infoPlaceHolderIndex = 1
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = false
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = true
//
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: "mind -onb")
//            infoPlaceHolderTitleRef.text = "Mind"
//            infoPlaceHolderDescRef.text = "Meditations and breath work exercises that are a perfect blend of neuroscience & spirituality."
//            infoPlaceHolderPageDotRef.image = UIImage(named: "secondPageDotIcon")
//
//        }
//        if isPlaceHolderScreen == false {
//
//        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
//        if pageIndex == 0{
//            pageIndex = pageIndex! + 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        }
//        else if pageIndex == 2 {
//            pageIndex = pageIndex! - 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        } else if pageIndex == 3 {
//            pageIndex = pageIndex! - 2
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        } else if pageIndex == 4 {
//            pageIndex = pageIndex! - 3
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        }
//        }
//    }
//
//    @objc func todayTabBtnTap() {
//
//        bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
//        todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        if isPlaceHolderScreen == false {
//
//        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
//        if pageIndex == 0{
//            pageIndex = pageIndex! + 2
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        }
//        else if pageIndex == 1 {
//            pageIndex = pageIndex! + 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        } else if pageIndex == 3 {
//            pageIndex = pageIndex! - 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        } else if pageIndex == 4 {
//            pageIndex = pageIndex! - 2
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        }
//        }
//
//    }
//
//    @objc func sleepTabBtnTap() {
//
//        bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.sleepSelectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepSelectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//
//        if isPlaceHolderScreen == true {
//            infoPlaceHolderIndex = 2
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = false
//            journalDownArrowAnimationViewRef.isHidden = true
//
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: "Sleep-onb")
//            infoPlaceHolderTitleRef.text = "Sleep"
//            infoPlaceHolderDescRef.text = "Sleep like a baby with our soothing sleep stories. Plug in as you travel to your dream world."
//            infoPlaceHolderPageDotRef.image = UIImage(named: "thirdPageDotIcon")
//
//        }
//        if isPlaceHolderScreen == false {
//
//        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
//        if pageIndex == 0{
//            pageIndex = pageIndex! + 3
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        }
//        else if pageIndex == 1 {
//            pageIndex = pageIndex! + 2
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        } else if pageIndex == 2 {
//            pageIndex = pageIndex! + 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        } else if pageIndex == 4 {
//            pageIndex = pageIndex! - 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
//        }
//        }
//    }
//
//    @objc func journalTabBtnTap() {
//
//        bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.journalSelectedColor
//        journalImgViewRef.image = UIImage(named: "JournalSelectedIcon")
//
//        if isPlaceHolderScreen == true {
//            infoPlaceHolderIndex = 3
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = false
//
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: "Journal-onb")
//            infoPlaceHolderTitleRef.text = "Journal"
//            infoPlaceHolderDescRef.text = "The safe space to pour your daily thoughts, intentions, reflections, and expressing gratitude."
//            infoPlaceHolderPageDotRef.image = UIImage(named: "fourthPageDotIcon")
//
//        }
//        if isPlaceHolderScreen == false {
//
//        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
//        if pageIndex == 0{
//            pageIndex = pageIndex! + 4
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        }
//        else if pageIndex == 1 {
//            pageIndex = pageIndex! + 3
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        } else if pageIndex == 2 {
//            pageIndex = pageIndex! + 2
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        } else if pageIndex == 3 {
//            pageIndex = pageIndex! + 1
//            pendingIndex = pageIndex!
//
//            let firstVC = VCArr[pageIndex!]
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        }
//        }
//    }
//
//    @IBAction func scheduleBtnTap(_ sender: UIButton) {
//        let vc = SchedularViewController.instantiate()
//        vc.pushDelegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func settingsBtnTap(_ sender: UIButton) {
//        let vc = SettingsViewController.instantiate()
//
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func addCoinsBtnTap(_ sender: UIButton) {
//        let vc = AddCoinsViewController.instantiate()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func skipBtnTap(_ sender: UIButton) {
//        self.isPlaceHolderScreen = false
//        self.infoPlaceHolderViewRef.isHidden = true
//
//        self.updateControlView()
//
//        bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
//        todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//
//        //}
//
//        UserDefaults.standard.set(false, forKey: "isPlaceHolderScreenShown")
//
//        if let userId = UserDefaults.standard.userDetails?.user?[0].id {
//
//            let todayDate = selectedDateFormatter.string(from: Date())
//            let todayValue = "SetMood \(userId) \(todayDate)"
//            let setValue = UserDefaults.standard.value(forKey: "isMoodSetToday") ?? ""
//
//            if todayValue != setValue as! String {
//
//                let vc = CustomSelectMoodPriorityPopUpVC.instantiate()
//
//                self.present(vc, animated: true)
//                vc.completion = { result in
//                    switch result {
//                    case .yes:
//                        print("Done")
//                        let xpVc = CustomXpEarnedPopUpVC.instantiate(xpEarned: "\(Environment.ActivityCoins.MOOD_PRIORITY_EARN_XP)", activityId: "0", activityType: "\(Environment.ActivityId.ACTIVITY_MOOD_PRIORITY)", activityCoins: "\(Environment.ActivityCoins.MOOD_PRIORITY_EARN_XP)")
//
//                        self.present(xpVc, animated: true)
//                        xpVc.completion = { result in
//                            switch result {
//
//                            case .LetsPlay:
//                                break
//
//                            case .back:
//                                print("back")
//                            }
//                        }
//
//
//                        //submodule is inserted at last position, increase container height before adding section
//                        //self.navigationController?.popViewController(animated: true)
//
//                        break
//
//                    case .no:
//
//                        UIView.animate(withDuration: 0.3, delay: 0, options: .layoutSubviews, animations: {
//                            self.view.layoutIfNeeded()
//                        })
//
//                    }
//                }
//            }
//        }
//
//        infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: infoPlaceholderArr[infoPlaceHolderIndex].animationName)
//        infoPlaceHolderTitleRef.text = infoPlaceholderArr[infoPlaceHolderIndex].title
//        infoPlaceHolderDescRef.text = infoPlaceholderArr[infoPlaceHolderIndex].desc
//        infoPlaceHolderPageDotRef.image = UIImage(named: infoPlaceholderArr[infoPlaceHolderIndex].pageDotImageViewName)
//
//        self.isPlaceHolderScreen = false
//        self.infoPlaceHolderViewRef.isHidden = true
//
//        self.updateControlView()
//
//        bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//        mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//        todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
//        todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
//
//        sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//        journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//        journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        let firstVC = VCArr[2] //{
//        pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
//        //}
//
//        UserDefaults.standard.set(false, forKey: "isPlaceHolderScreenShown")
//
//    }
//
//    @objc func leftInfoViewTapped() {
//
//        if infoPlaceHolderIndex == 0 {
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: infoPlaceholderArr[infoPlaceHolderIndex].animationName)
//            infoPlaceHolderTitleRef.text = infoPlaceholderArr[infoPlaceHolderIndex].title
//            infoPlaceHolderDescRef.text = infoPlaceholderArr[infoPlaceHolderIndex].desc
//            infoPlaceHolderPageDotRef.image = UIImage(named: infoPlaceholderArr[infoPlaceHolderIndex].pageDotImageViewName)
//        } else {
//            infoPlaceHolderIndex = infoPlaceHolderIndex - 1
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: infoPlaceholderArr[infoPlaceHolderIndex].animationName)
//            infoPlaceHolderTitleRef.text = infoPlaceholderArr[infoPlaceHolderIndex].title
//            infoPlaceHolderDescRef.text = infoPlaceholderArr[infoPlaceHolderIndex].desc
//            infoPlaceHolderPageDotRef.image = UIImage(named: infoPlaceholderArr[infoPlaceHolderIndex].pageDotImageViewName)
//        }
//
//        if infoPlaceHolderIndex == 0 {
//
//            bodyDownArrowAnimationViewRef.isHidden = false
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = true
//
//        } else if infoPlaceHolderIndex == 1 {
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = false
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = true
//
//        } else if infoPlaceHolderIndex == 2 {
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = false
//            journalDownArrowAnimationViewRef.isHidden = true
//
//        } else if infoPlaceHolderIndex == 3 {
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = false
//
//        }
//
//        if infoPlaceHolderIndex == 0 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.bodySelectedColor
//            bodyImgViewRef.image = UIImage(named: "BodySelectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        } else if infoPlaceHolderIndex == 1 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.mindSelectedColor
//            mindImgViewRef.image = UIImage(named: "MindSelectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        } else if infoPlaceHolderIndex == 2 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.sleepSelectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepSelectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        } else if infoPlaceHolderIndex == 3 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.journalSelectedColor
//            journalImgViewRef.image = UIImage(named: "JournalSelectedIcon")
//        }
//
//
//
//    }
//
//    @objc func rightInfoViewTapped() {
//
//        if infoPlaceHolderIndex == 3 {
//
//            if let userId = UserDefaults.standard.userDetails?.user?[0].id {
//
//                let todayDate = selectedDateFormatter.string(from: Date())
//                let todayValue = "SetMood \(userId) \(todayDate)"
//                let setValue = UserDefaults.standard.value(forKey: "isMoodSetToday") ?? ""
//
//                if todayValue != setValue as! String {
//
//                    let vc = CustomSelectMoodPriorityPopUpVC.instantiate()
//
//                    self.present(vc, animated: true)
//                    vc.completion = { result in
//                        switch result {
//                        case .yes:
//                            print("Done")
//                            let xpVc = CustomXpEarnedPopUpVC.instantiate(xpEarned: "\(Environment.ActivityCoins.MOOD_PRIORITY_EARN_XP)", activityId: "0", activityType: "\(Environment.ActivityId.ACTIVITY_MOOD_PRIORITY)", activityCoins: "\(Environment.ActivityCoins.MOOD_PRIORITY_EARN_XP)")
//
//                            self.present(xpVc, animated: true)
//                            xpVc.completion = { result in
//                                switch result {
//
//                                case .LetsPlay:
//                                    self.bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//                                    self.bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//                                    self.mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//                                    self.mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//                                    self.todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
//                                    self.todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
//
//                                    self.sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//                                    self.sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//                                    self.journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//                                    self.journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//                                case .back:
//                                    print("back")
//                                }
//                            }
//
//
//                            //submodule is inserted at last position, increase container height before adding section
//                            //self.navigationController?.popViewController(animated: true)
//
//                            break
//
//                        case .no:
//
//                            UIView.animate(withDuration: 0.3, delay: 0, options: .layoutSubviews, animations: {
//                                self.view.layoutIfNeeded()
//                            })
//
//                        }
//                    }
//                }
//            }
//
//
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: infoPlaceholderArr[infoPlaceHolderIndex].animationName)
//            infoPlaceHolderTitleRef.text = infoPlaceholderArr[infoPlaceHolderIndex].title
//            infoPlaceHolderDescRef.text = infoPlaceholderArr[infoPlaceHolderIndex].desc
//            infoPlaceHolderPageDotRef.image = UIImage(named: infoPlaceholderArr[infoPlaceHolderIndex].pageDotImageViewName)
//
//            self.isPlaceHolderScreen = false
//            self.infoPlaceHolderViewRef.isHidden = true
//
//            self.updateControlView()
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
//            todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//            let firstVC = VCArr[2] //{
//            pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
//            //}
//
//            UserDefaults.standard.set(false, forKey: "isPlaceHolderScreenShown")
//        } else {
//            infoPlaceHolderIndex = infoPlaceHolderIndex + 1
//            infoPlaceholderAnimation(animationView: infoPlaceHolderAnimationRef, animationJson: infoPlaceholderArr[infoPlaceHolderIndex].animationName)
//            infoPlaceHolderTitleRef.text = infoPlaceholderArr[infoPlaceHolderIndex].title
//            infoPlaceHolderDescRef.text = infoPlaceholderArr[infoPlaceHolderIndex].desc
//            infoPlaceHolderPageDotRef.image = UIImage(named: infoPlaceholderArr[infoPlaceHolderIndex].pageDotImageViewName)
//        }
//
//        if infoPlaceHolderIndex == 0 {
//
//            bodyDownArrowAnimationViewRef.isHidden = false
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = true
//
//        } else if infoPlaceHolderIndex == 1 {
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = false
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = true
//
//        } else if infoPlaceHolderIndex == 2 {
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = false
//            journalDownArrowAnimationViewRef.isHidden = true
//
//        } else if infoPlaceHolderIndex == 3 {
//
//            bodyDownArrowAnimationViewRef.isHidden = true
//            mindDownArrowAnimationViewRef.isHidden = true
//            sleepDownArrowAnimationViewRef.isHidden = true
//            journalDownArrowAnimationViewRef.isHidden = false
//
//        }
//
//        if infoPlaceHolderIndex == 0 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.bodySelectedColor
//            bodyImgViewRef.image = UIImage(named: "BodySelectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        } else if infoPlaceHolderIndex == 1 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.mindSelectedColor
//            mindImgViewRef.image = UIImage(named: "MindSelectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        } else if infoPlaceHolderIndex == 2 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.sleepSelectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepSelectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
//
//        } else if infoPlaceHolderIndex == 3 {
//
//            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
//
//            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
//
//            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
//
//            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
//            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
//
//            journalLblRef.textColor = Environment.GlobarlUrls.journalSelectedColor
//            journalImgViewRef.image = UIImage(named: "JournalSelectedIcon")
//        }
//    }
//
//}

//MARK: - Page Control
extension HomeVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
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
        
        pendingIndex = VCArr.firstIndex(of: pendingViewControllers.first!)!
        updateControlView()
    }
    
    private func updateControlView() {
        /*if pendingIndex == 0 {
            
            bodyLblRef.textColor = Environment.GlobarlUrls.bodySelectedColor
            bodyImgViewRef.image = UIImage(named: "BodySelectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
        } else if pendingIndex == 1 {
            
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.mindSelectedColor
            mindImgViewRef.image = UIImage(named: "MindSelectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
        } else if pendingIndex == 2 {
            
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.todaySelectedColor
            todayImgViewRef.image = UIImage(named: "TodaySelectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
        } else if pendingIndex == 3 {
            
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.sleepSelectedColor
            sleepImgViewRef.image = UIImage(named: "SleepSelectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            journalImgViewRef.image = UIImage(named: "JournalUnselectedIcon")
            
        } else if pendingIndex == 4 {
            
            bodyLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            bodyImgViewRef.image = UIImage(named: "BodyUnselectedIcon")
            
            mindLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            mindImgViewRef.image = UIImage(named: "MindUnselectedIcon")
            
            todayLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            todayImgViewRef.image = UIImage(named: "TodayUnselectedIcon")
            
            sleepLblRef.textColor = Environment.GlobarlUrls.tabUnselectedColor
            sleepImgViewRef.image = UIImage(named: "SleepUnselectedIcon")
            
            journalLblRef.textColor = Environment.GlobarlUrls.journalSelectedColor
            journalImgViewRef.image = UIImage(named: "JournalSelectedIcon")
        } */
        
    }
    
    
}
