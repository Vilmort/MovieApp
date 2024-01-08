//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import UIKit
import SnapKit

class ImageSelectionViewController: UIViewController {

  private var profileImageNames = ["ProfilePictureEdit", "ProfilePicture1", "ProfilePicture2", "ProfilePicture3", "ProfilePicture4"]
    
  private let scrollView = UIScrollView()
  private var imagePicker = UIImagePickerController()
  private var profileImageSelectedIndex = 0
  var delegate: ImageSelectionDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupScrollView()
    setupImages()
    setupConstraints()
    setupImagePicker()
  }

  private func setupView() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    view.addGestureRecognizer(tapGesture)
  }

  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isScrollEnabled = true
    scrollView.showsHorizontalScrollIndicator = true
    scrollView.contentSize = CGSize(width: 1200, height: 200)
    view.addSubview(scrollView)
  }

  private func setupImages() {
    var xOffset: CGFloat = 50
    for (_, imageName) in profileImageNames.enumerated() {
      if let image = UIImage(named: imageName) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: xOffset, y: 20, width: 150, height: 150)
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)

        if imageName == "ProfilePictureEdit" {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageAddTapped(_:)))
          imageView.addGestureRecognizer(tapGesture)
        } else {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageOtherTapped(_:)))
          imageView.addGestureRecognizer(tapGesture)
        }

        xOffset += 170
      }
    }
  }

  @objc func imageOtherTapped(_ sender: UITapGestureRecognizer) {
    guard let tappedImageView = sender.view as? UIImageView,
          let tappedIndex = scrollView.subviews.firstIndex(of: tappedImageView),
          tappedIndex >= 1 else {
      return
    }
    if let tappedImage = tappedImageView.image {
      delegate?.didUpdateProfileImage(tappedImage)
    }
  }

  private func setupImagePicker() {
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
  }

  private func setupConstraints() {
      scrollView.snp.makeConstraints { make in
              make.height.equalTo(200)
              make.width.equalTo(600)
              make.centerY.equalTo(view.snp.centerY)
          }
  }

  @objc func viewTapped(sender: UITapGestureRecognizer) {
    let tapLocation = sender.location(in: self.view)
    if let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView,
       scrollView.frame.contains(tapLocation) {
      return
    }
    self.dismiss(animated: true, completion: nil)
  }

  @objc func imageAddTapped(_ sender: UITapGestureRecognizer) {
    guard let tappedImageView = sender.view as? UIImageView,
          let tappedIndex = scrollView.subviews.firstIndex(of: tappedImageView) else {
      return
    }
    profileImageSelectedIndex = tappedIndex
    present(imagePicker, animated: true, completion: nil)
  }
}

//MARK: = Extension
extension ImageSelectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let selectedImage = info[.originalImage] as? UIImage {
      profileImageNames[profileImageSelectedIndex] = "ProfilePictureSelected"
      if let imageView = scrollView.subviews[profileImageSelectedIndex] as? UIImageView {
        imageView.image = selectedImage
        delegate?.didUpdateProfileImage(selectedImage)
      }
    }
    picker.dismiss(animated: true, completion: nil)

  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}

//MARK: = Protocol
protocol ImageSelectionDelegate: AnyObject {
  func didUpdateProfileImage(_ image: UIImage)
}
