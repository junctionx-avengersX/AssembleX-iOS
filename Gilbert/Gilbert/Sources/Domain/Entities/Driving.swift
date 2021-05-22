import Foundation

// MARK: - Welcome
struct Driving: Codable {
    let code: Int
    let message: String
    let currentDateTime: String
    let route: Route
}

// MARK: - Route
struct Route: Codable {
    let trafast: [Trafast]
}

// MARK: - Trafast
struct Trafast: Codable {
    let summary: Summary
    let path: [[Double]]
    let section: [Section]
    let guide: [Guide]
}

// MARK: - Guide
struct Guide: Codable {
    let pointIndex, type: Int
    let instructions: String
    let distance, duration: Int
}

// MARK: - Section
struct Section: Codable {
    let pointIndex, pointCount, distance: Int
    let name: String
    let congestion, speed: Int
}

// MARK: - Summary
struct Summary: Codable {
    let start: Start
    let goal: Goal
    let distance, duration: Int
    let bbox: [[Double]]
    let tollFare, taxiFare, fuelPrice: Int
}

// MARK: - Goal
struct Goal: Codable {
    let location: [Double]
    let dir: Int
}

// MARK: - Start
struct Start: Codable {
    let location: [Double]
}
