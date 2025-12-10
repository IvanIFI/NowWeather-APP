//
//  DrawerProtocol.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import UIKit

public protocol DrawerProtocol {
    var cellDrawer: CellDrawerProtocol { get }
}

public protocol CellDrawerProtocol {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func drawCell (_ cell: UITableViewCell, withItem item: Any)
}
