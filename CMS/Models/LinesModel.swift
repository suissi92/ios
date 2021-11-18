//
//  LinesModel.swift
//  CMS
//
//  Created by Haithem Rekik on 13/11/2021.
//

import Foundation

// MARK: - Machine
struct Line: Codable {
    let id: Int
    let name, Description: String
    let machines: Machines
}

typealias LinesModel = [Line]
