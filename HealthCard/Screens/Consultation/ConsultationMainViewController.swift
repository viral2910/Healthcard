//
//  ConsultationMainViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import UIKit

class ConsultationMainViewController: UIViewController, XIBed, PushViewControllerDelegate {
    @IBOutlet weak var specialityBtnRef: UIButton!
    @IBOutlet weak var specialityBtnBottomLineRef: UIView!
    @IBOutlet weak var symptomsBtnRef: UIButton!
    @IBOutlet weak var symptomsBtnBottomLineRef: UIView!
    
    ///Container View
    @IBOutlet weak var containerView: UIView!
    


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
                let vc = ConsultSpecialityViewController.instantiate()
                vc.pushDelegate = pushDelegate
                return UINavigationController(rootViewController: vc)
            }(),
            {
                let vc = ConsultSymptomsViewController.instantiate()
                vc.pushDelegate = pushDelegate
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
extension ConsultationMainViewController {
    func setupUI() {
        symptomsBtnBottomLineRef.backgroundColor = .clear
        specialityBtnBottomLineRef.backgroundColor = selectedLineColor
        specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)//UIFont.systemFont(ofSize: 16)
        self.setupPageControl()
        
        if screenType == 0 {
            symptomsBtnBottomLineRef.backgroundColor = .clear
            specialityBtnBottomLineRef.backgroundColor = UIColor.init(hexString: "007AB8")
            symptomsBtnRef.setTitleColor(unSelectedTextColor, for: .normal)
            specialityBtnRef.setTitleColor(UIColor.black, for: .normal)
            
            symptomsBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
            if let firstVC = self.VCArr.first {
                self.pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
            }
            
        } else if screenType == 1 {
            symptomsBtnBottomLineRef.backgroundColor = UIColor.black
            specialityBtnBottomLineRef.backgroundColor = .clear
            symptomsBtnRef.setTitleColor(UIColor.black, for: .normal)
            specialityBtnRef.setTitleColor(UIColor.lightGray, for: .normal)

            specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            symptomsBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
            let firstVC = VCArr[1] //{
                pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        

        
    }
    
    func setupCornerShadow() {
        
        specialityBtnBottomLineRef.layer.cornerRadius = specialityBtnBottomLineRef.bounds.height * 0.5

        symptomsBtnBottomLineRef.layer.cornerRadius = symptomsBtnBottomLineRef.bounds.height * 0.5
        
        
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
extension ConsultationMainViewController {
    @IBAction func specialityBtnTap(_ sender: UIButton) {
        symptomsBtnBottomLineRef.backgroundColor = .clear
        specialityBtnBottomLineRef.backgroundColor = selectedLineColor
        symptomsBtnRef.setTitleColor(unSelectedTextColor, for: .normal)
        specialityBtnRef.setTitleColor(UIColor.black, for: .normal)
        
        symptomsBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
        if pageIndex == 1{
            pageIndex = pageIndex! - 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        }
        

    }
    
    @IBAction func symptomsBtnTap(_ sender: UIButton) {
        symptomsBtnBottomLineRef.backgroundColor = selectedLineColor
        specialityBtnBottomLineRef.backgroundColor = .clear
        symptomsBtnRef.setTitleColor(selectedTextColor, for: .normal)
        specialityBtnRef.setTitleColor(unSelectedTextColor, for: .normal)

        specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        symptomsBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        var pageIndex = VCArr.firstIndex(of: (self.pageVC.viewControllers?[0])!)
        if pageIndex == 0{
            pageIndex = pageIndex! + 1
            pendingIndex = pageIndex!
            
            let firstVC = VCArr[pageIndex!]
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

    }
    
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
    }

}
//MARK: - Page Control
extension ConsultationMainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
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

            symptomsBtnBottomLineRef.backgroundColor = .clear
            specialityBtnBottomLineRef.backgroundColor = selectedLineColor
            symptomsBtnRef.setTitleColor(unSelectedTextColor, for: .normal)
            specialityBtnRef.setTitleColor(selectedTextColor, for: .normal)
            
            symptomsBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                        
        } else if pendingIndex == 1 {

            symptomsBtnBottomLineRef.backgroundColor = selectedLineColor
            specialityBtnBottomLineRef.backgroundColor = .clear
            symptomsBtnRef.setTitleColor(selectedTextColor, for: .normal)
            specialityBtnRef.setTitleColor(unSelectedTextColor, for: .normal)

            specialityBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            symptomsBtnRef.titleLabel?.font = UIFont.systemFont(ofSize: 16)

            
        }
        
    }
    
    
}


