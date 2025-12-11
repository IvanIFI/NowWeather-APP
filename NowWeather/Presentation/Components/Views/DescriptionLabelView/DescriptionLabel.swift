//
//  DescriptionLabel.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 11/12/25.
//

import UIKit

internal struct DescriptionLabelModel {
    var description: String?
    
    init(description: String?) {
        self.description = description
    }
}

class DescriptionLabel: UIView {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let nibDescriptionLabel = UINib(nibName: "DescriptionLabel", bundle: nil)
        guard let descriptionLabelView = nibDescriptionLabel.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error instantiating the view DescriptionLabel") }
        
        descriptionLabelView.frame = bounds
        descriptionLabelView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(descriptionLabelView)
    }
    
    func bind(model: DescriptionLabelModel){
        if model.description != nil {
            descriptionLabel.text = model.description
        }
    }
    
}
