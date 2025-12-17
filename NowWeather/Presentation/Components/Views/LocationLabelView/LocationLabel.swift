//
//  LocationLabel.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 11/12/25.
//

import UIKit

internal struct LocationLabelModel {
    var location: String?
    
    init(location: String?) {
        self.location = location
    }
}

class LocationLabel: UIView {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let nibLocationLabel = UINib(nibName: "LocationLabel", bundle: nil)
        guard let locationLabelView = nibLocationLabel.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error instantiating the view LocationLabel") }
        
        locationLabelView.frame = bounds
        locationLabelView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(locationLabelView)
    }
    
    func bind(model: LocationLabelModel){
        if model.location != nil {
            locationLabel.text = model.location
        }
    }
    
}
