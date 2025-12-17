//
//  Utils.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import Foundation

final class Utils {
    
    static func formatTemperatura(temp: Double) -> String {
        return String(format: "%.0f°", temp)
    }
    
    static func formatDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    static func iconForWeather(code: String) -> String {
        switch code {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.rain.fill"
        case "13d", "13n": return "snowflake"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "questionmark.circle.fill"
        }
    }
    
}
