//
//  DateManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 12.10.2022.
//

import Foundation

class DateManager {
  
  private let formatter = DateFormatter()
  
  func parseISO8601Date(string: String) -> String? {
    let formatter8601 = ISO8601DateFormatter()
    formatter8601.formatOptions.insert(.withFractionalSeconds)
    guard let date = formatter8601.date(from: string) else { return nil }
    formatter.dateFormat = "MM.dd.yyyy"
    return formatter.string(from: date)
  }
  
  func getCurrentTime() -> String {
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: Date())
  }
  
  func getTimeByTimezone(timezone: String) -> String? {
    guard let timeZone = TimeZone(abbreviation: "GMT\(timezone)") else { return nil }
    formatter.timeZone = timeZone
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: Date())
  }
}
