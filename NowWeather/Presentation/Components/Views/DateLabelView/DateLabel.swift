//
//  DateLabel.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit

internal struct DateLabelModel {
    var date: String?
    
    init(date: String?) {
        self.date = date
    }
}

class DateLabel: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let nibDateLabel = UINib(nibName: "DateLabel", bundle: nil)
        guard let dateLabelView = nibDateLabel.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error instantiating the view DateLabel") }
        
        dateLabelView.frame = bounds
        dateLabelView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(dateLabelView)
    }
    
    func bind(model: DateLabelModel){
        if model.date != nil {
            dateLabel.text = model.date
        }
    }
    
}
