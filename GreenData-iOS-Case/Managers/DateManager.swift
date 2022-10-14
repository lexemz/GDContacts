//
//  DateManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 12.10.2022.
//

import Foundation

final class DateManager {
  private let formatter = DateFormatter()
  
  private var timer: Timer?
  
  deinit {
    timer?.invalidate()
  }
  
  func parseISO8601Date(string: String) -> String? {
    let formatter8601 = ISO8601DateFormatter()
    formatter8601.formatOptions.insert(.withFractionalSeconds)
    guard let date = formatter8601.date(from: string) else { return nil }
    formatter.dateFormat = "MM.dd.yyyy"
    return formatter.string(from: date)
  }
  
  func startTrackingLiveTime(
    for timezone: String,
    tickHandler: ((_ contactTime: String, _ deviceTime: String) -> Void)?
  ) {
    let timerFormatter = DateFormatter()
    timerFormatter.dateFormat = "HH:mm:ss"
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
      var contactTimeStrng = "N/A"
      
      if let localTimeZone = TimeZone(abbreviation: "GMT\(timezone)") {
        timerFormatter.timeZone = localTimeZone
        contactTimeStrng = timerFormatter.string(from: Date())
      }
      timerFormatter.timeZone = .current
      let deviceTimeString = timerFormatter.string(from: Date())
      
      tickHandler?(contactTimeStrng, deviceTimeString)
    }
    timer?.fire()
  }
}
