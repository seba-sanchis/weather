//
//  ErrorService.swift
//  weather
//
//  Created by Sebastian Sanchis on 16/11/2023.
//

import Foundation

enum ErrorService: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
