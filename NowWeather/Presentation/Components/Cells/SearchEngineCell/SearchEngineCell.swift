//
//  SearchEngineCell.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit

class SearchEngineCell: UITableViewCell {
    
    static let reuseId = "SearchEngine"

    @IBOutlet weak var searchEngine: SearchEngine!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class SearchEngineCellDrawer: CellDrawerProtocol {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: SearchEngineCell.reuseId, for: indexPath)
    }
    
    func drawCell(_ cell: UITableViewCell, withItem item: Any) {
        guard let cell = cell as? SearchEngineCell,
              let item = item as? SearchEngineModel else { return }
        
        cell.selectionStyle = .none
        cell.searchEngine.bind(model: item)
    }
    
}

// MARK: - DrawerProtocol
extension SearchEngineModel: DrawerProtocol{
    public var cellDrawer: any CellDrawerProtocol {
        return SearchEngineCellDrawer()
    }
}
