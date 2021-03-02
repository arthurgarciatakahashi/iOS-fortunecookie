//
//  FortuneViewController.swift
//  UI
//
//  Created by arthur takahashi on 01/03/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import UIKit
import Presentation
import Domain

public final class FortuneViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, Storyboarded {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataCategories.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerDataCategories[row]
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryType = pickerDataCategories[row]
    }
    
    @IBOutlet weak var breakOpenButton: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    
    public var fortune: ((FortuneRequest) -> Void)?
    public var categoryType = "all"
    private var pickerDataCategories = [
        "all",
        "bible",
        "computers",
        "cookie",
        "definitions",
        "miscellaneous",
        "people",
        "platitudes",
        "politics",
        "science",
        "winsdom"]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Fortune Cookie"
        breakOpenButton?.addTarget(self, action: #selector(fortuneButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
        category.dataSource = self
        category.delegate = self
    }
    
    @objc private func fortuneButtonTapped() {
        fortune?(FortuneRequest(category: CategoryType(rawValue: categoryType)))
    }
}

extension FortuneViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator?.stopAnimating()
        }
    }
}

extension FortuneViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}

