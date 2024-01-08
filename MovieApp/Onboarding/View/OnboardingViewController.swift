//
//  OnboardingViewController.swift
//  MovieApp
//
//  Created by Vanopr on 27.12.2023.
//

import UIKit
import SnapKit
import Lottie

class OnboardingViewController: ViewController, OnboardingViewProtocol {
    
    var presenter: OnboardingPresenterProtocol!
    
    //MARK: - Properties
    private var slides = [OnboardingView]()
    private var currentPageIndex = 0
    //MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var skipButton: UIButton = {
        let skipButton = UIButton(type: .system)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor.lightGray, for: .normal)
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        return skipButton
    }()
    
    private let animationButton: LottieAnimationView = .init()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegates()
        setConstraints()
        currentButtons()
        slides = presenter.createSlides()
        setupSlidesScrollView(slides: slides)
        setupAnimationButton()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupAnimationButton() {
        animationButton.animation = LottieAnimation.named("OnboardingNext")
        animationButton.loopMode = .playOnce
        animationButton.play(fromFrame: 0, toFrame: 200)
        animationButton.animationSpeed = 4
        animationButton.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
        animationButton.addGestureRecognizer(tapGesture)
    }
    
    private func playAnimationFor(_ page: Int) {
        switch page {
        case 0:
            animationButton.play(toFrame: 200)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
            animationButton.addGestureRecognizer(tapGesture)
        case 1:
            animationButton.play(toFrame: 400)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
            animationButton.addGestureRecognizer(tapGesture)
        case 2:
            animationButton.play(toFrame: 600)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(skipButtonPressed))
            animationButton.addGestureRecognizer(tapGesture)
        default:
            break
        }
    }
    
    //MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .appDark
        view.addSubview(scrollView)
        view.addSubview(skipButton)
        view.addSubview(animationButton)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func currentButtons() {
        skipButton.isHidden = presenter.ifSkipButtonHidden(id: currentPageIndex)
    }
    
    private func goToHomeScreen() {
        presenter.safeUserDefaults()
        presenter.goToHomeScreen()
    }
    //MARK: - Actions
    
    @objc private func nextSlide() {
        let nextPageIndex = currentPageIndex + 1
        guard nextPageIndex < slides.count else {
            goToHomeScreen()
            return
        }
        let xOffset = scrollView.frame.width * CGFloat(nextPageIndex)
        scrollView.setContentOffset(CGPoint(x: xOffset, y: scrollView.contentOffset.y), animated: true)
        currentPageIndex = nextPageIndex
        currentButtons()
        playAnimationFor(currentPageIndex)
    }
    
    @objc private func skipButtonPressed() {
        goToHomeScreen()
    }
    
    
    private func setupSlidesScrollView(slides: [OnboardingView]) {
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                        height: scrollView.frame.height)
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    
}

// MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxHorizontalOfSet = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOfSet
        
        if percentHorizontalOffset <= 0.5 {
            slides[0].setPageLabelTransform(transform: presenter.firstTransform(when: percentHorizontalOffset))
            slides[1].setPageLabelTransform(transform: presenter.secondTransform(when: percentHorizontalOffset))
        } else {
            slides[1].setPageLabelTransform(transform: presenter.thirdTransform(when: percentHorizontalOffset))
            slides[2].setPageLabelTransform(transform: presenter.forthTransform(when: percentHorizontalOffset))
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffsetX = targetContentOffset.pointee.x
        let currentPageIndex = Int(targetOffsetX / view.frame.width)
        self.currentPageIndex = currentPageIndex
        currentButtons()
        playAnimationFor(currentPageIndex)
    }
}

// MARK: - Set Constraints

extension OnboardingViewController {
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(animationButton.snp.top)
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        animationButton.snp.makeConstraints { make in
            make.bottom.equalTo(skipButton.snp.top)
            make.trailing.equalToSuperview().inset(15)
            make.width.height.equalTo(80)
        }
    }
}


