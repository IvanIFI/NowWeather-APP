//
//  SearchEngine.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit
 
internal struct SearchEngineModel {
    var placeholder: String?

    init(placeholder: String?) {
        self.placeholder = placeholder
    }
}
 
class SearchEngine: UIView {
 
    @IBOutlet weak var searchBar: UISearchBar!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    private func setupUI() {
        let nib = UINib(nibName: "SearchEngine", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error instantiating the view SearchEngine")
        }

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)

        configureSearchBar()

    }

    private func configureSearchBar() {
        searchBar.searchTextField.rightView = nil

        let textField = searchBar.searchTextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
    }

    func bind(model: SearchEngineModel) {
        searchBar.placeholder = model.placeholder
    }

}
 
