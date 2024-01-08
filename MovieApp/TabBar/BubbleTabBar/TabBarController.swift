//
//  TabBarController.swift
//  MovieApp
//
//  Created by Vanopr on 24.12.2023.
//


import UIKit

 class TabBarController: UITabBarController, TabBarViewProtocol  {

    fileprivate var shouldSelectOnTabBar = true
    
    var presenter: TabBarPresenterProtocol!
    let customTabBar: TabBar
    
    init(customTabBar: TabBar) {
        self.customTabBar = customTabBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? TabBar, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? TabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
     }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(customTabBar, forKey: "tabBar")
        createTabBar()
    }

    private var _barHeight: CGFloat = 74
    open var barHeight: CGFloat {
        get {
                return _barHeight + view.safeAreaInsets.bottom
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }

    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

    open override func viewSafeAreaInsetsDidChange() {
            super.viewSafeAreaInsetsDidChange()
        updateTabBarFrame()
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
    
    private func generateVC(_ viewController: UIViewController, _ title: String?, _ image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let vc = NavigationController(rootViewController: viewController)
  return vc
    }
    
 
    //MARK: - CreateTabBar
    private func createTabBar() {
        let homeVC = Builder.createHome()
        let searchVC = Builder.createSearch()
        let treeVC = Builder.createTree()
        let profileVC = Builder.createProfile()
        
        viewControllers = [
            generateVC(homeVC, "Home".localized, .home),
            generateVC(searchVC, "Search".localized, .search),
            generateVC(treeVC, "Tree".localized, .puzzle),
            generateVC(profileVC, "Profile".localized, .profileTab)
        ]
    }

}
