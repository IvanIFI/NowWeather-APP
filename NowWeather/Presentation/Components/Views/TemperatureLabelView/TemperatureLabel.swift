//
//  TemperatureLabel.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit

internal struct TemperatureModel {
    var temperature: String?
    
    init(temperature: String?) {
        self.temperature = temperature
    }
}

class TemperatureLabel: UIView {

    @IBOutlet weak var temperatureLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let nibTemperatureLabel = UINib(nibName: "TemperatureLabel", bundle: nil)
        guard let temperatureLabelView = nibTemperatureLabel.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error instantiating the view TemperatureLabel") }
        
        temperatureLabelView.frame = bounds
        temperatureLabelView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(temperatureLabelView)
    }
    
    func bind(model: TemperatureModel){
        if model.temperature != nil {
            temperatureLabel.text = model.temperature
        }
    }
}
