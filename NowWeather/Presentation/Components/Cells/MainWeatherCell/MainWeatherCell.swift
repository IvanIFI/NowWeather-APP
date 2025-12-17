//
//  MainWeatherCell.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit

internal struct MainWeatherCellModel {
    var imageModel: ImageWeatherModel?
    var dateModel: DateLabelModel?
    var temperatureModel: TemperatureModel?
    var locationModel: LocationLabelModel?
    var descriptionModel: DescriptionLabelModel?
    
    init(_ imageModel: ImageWeatherModel?,_ dateModel: DateLabelModel?,_ temperatureModel: TemperatureModel?,
         _ locationModel: LocationLabelModel?,_ descriptionModel: DescriptionLabelModel?) {
        self.imageModel = imageModel
        self.dateModel = dateModel
        self.temperatureModel = temperatureModel
        self.locationModel = locationModel
        self.descriptionModel = descriptionModel
    }
}

class MainWeatherCell: UITableViewCell {
    
    static let reuseId = "MainWeatherCell"
    
    @IBOutlet weak var imageWeather: WeatherImage!
    @IBOutlet weak var temperatureLabel: TemperatureLabel!
    @IBOutlet weak var dateLabel: DateLabel!
    @IBOutlet weak var locationLabel: LocationLabel!
    @IBOutlet weak var descriptionLabel: DescriptionLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class MainWeatherCellDrawer: CellDrawerProtocol{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: MainWeatherCell.reuseId, for: indexPath)
    }
    
    func drawCell(_ cell: UITableViewCell, withItem item: Any) {
        guard let cell = cell as? MainWeatherCell,
              let item = item as? MainWeatherCellModel else { return }
        
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 14
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.contentView.layer.cornerRadius = 14
        cell.contentView.layer.masksToBounds = true
     
        cell.imageWeather.bind(model: item.imageModel ?? ImageWeatherModel(image: ""))
        cell.dateLabel.bind(model: item.dateModel ?? DateLabelModel(date: ""))
        cell.temperatureLabel.bind(model: item.temperatureModel ?? TemperatureModel(temperature: ""))
        cell.locationLabel.bind(model: item.locationModel ?? LocationLabelModel(location: ""))
        cell.descriptionLabel.bind(model: item.descriptionModel ?? DescriptionLabelModel(description: ""))
    }
    
}

// MARK: - DrawerProtocol
extension MainWeatherCellModel: DrawerProtocol{
    public var cellDrawer: any CellDrawerProtocol {
        return MainWeatherCellDrawer()
    }
}
