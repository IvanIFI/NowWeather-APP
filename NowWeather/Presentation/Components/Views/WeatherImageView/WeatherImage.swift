//
//  WeatherImage.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit

internal struct ImageWeatherModel {
    var image: String?
    
    init(image: String?) {
        self.image = image
    }
}

class WeatherImage: UIView {

    @IBOutlet weak var imageWeather: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    private func setupUI() {
        let nibImageWeather = UINib(nibName: "WeatherImage", bundle: nil)
        guard let imageWeatherView = nibImageWeather
            .instantiate(withOwner: self,options: nil).first as? UIView else{
            fatalError("Error instantiating the view WeatherImage")
        }
        
        imageWeatherView.frame = bounds
        imageWeatherView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(imageWeatherView)
    }
    
    func bind(model: ImageWeatherModel){
        if let imageName = model.image {
            imageWeather.image = UIImage(systemName: imageName)
        } else {
            imageWeather.image = UIImage(systemName: "x.circle")
        }
    }
}
