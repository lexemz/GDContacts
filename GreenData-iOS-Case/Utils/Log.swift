//
//  Log.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

class Log {
  private struct Context {
    enum LogLevel: String {
      case info = "[INFO]"
      case warning = "🟨[WARN]"
      case error = "🟥[ERROR]"
    }

    let type: LogLevel
    let time: String
    let file: String
    let line: Int
    let function: String
    let tag: String?
    let data: String

    var result: String {
      if let tag = tag {
        return "\(type.rawValue)\(time)[\(file)::\(line)][\(function)][tag: \(tag)] |>\(data)<|"
      } else {
        return "\(type.rawValue)\(time)[\(file)::\(line)][\(function)] |>\(data)<|"
      }
    }
  }

  private static let formatter = DateFormatter()
  private static var logTime: String {
    formatter.dateFormat = "HH:mm:ss"
    return "[\(formatter.string(from: Date()))]"
  }

  private init() {}

  static func d(
    file: String = #file,
    line: Int = #line,
    function: String = #function,
    _ items: Any...,
    tag: String? = nil
  ) {
    var dataString = " "
    items.forEach {
      dataString += String(describing: $0) + " "
    }

    let context = Context(
      type: .info,
      time: logTime,
      file: extractFileName(from: file),
      line: line,
      function: function,
      tag: tag,
      data: dataString
    )
    print(context.result)
  }

  static func w(
    file: String = #file,
    line: Int = #line,
    function: String = #function,
    _ items: Any...,
    tag: String? = nil
  ) {
    var dataString = " "
    items.forEach {
      dataString += String(describing: $0) + " "
    }

    let context = Context(
      type: .warning,
      time: logTime,
      file: extractFileName(from: file),
      line: line,
      function: function,
      tag: tag,
      data: dataString
    )
    print(context.result)
  }

  static func e(
    file: String = #file,
    line: Int = #line,
    function: String = #function,
    _ items: Any...,
    tag: String? = nil
  ) {
    var dataString = " "
    items.forEach {
      dataString += String(describing: $0) + " "
    }

    let context = Context(
      type: .error,
      time: logTime,
      file: extractFileName(from: file),
      line: line,
      function: function,
      tag: tag,
      data: dataString
    )
    print(context.result)
  }

  private static func extractFileName(from path: String) -> String {
    path.components(separatedBy: "/").last ?? "[No file path]"
  }
}
