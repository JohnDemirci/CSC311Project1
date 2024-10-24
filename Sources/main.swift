// The Swift Programming Language
// https://docs.swift.org/swift-book
//

import Foundation

if #available(macOS 14, *) {
    let driver = Driver()
    driver.run()
} else {
    // Fallback on earlier versions
}
