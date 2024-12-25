//
//  Endpoint.swift
//  iegobetsPW5
//
//  Created by Ivan on 25.12.2024.
//

import Foundation

protocol Endpoint {
    var compositePath: String { get }
    var headers: [String: String] { get }
    var parametrs: [String: String]? { get }
}

extension Endpoint {
    var parametrs: [String: String]? { return nil }
}
