//
//  MachinesModel.swift
//  CMS
//
//  Created by MacBook on 31/10/2021.
//

import Foundation

// MARK: - Machine
struct Machine: Codable {
    let id: Int
    let name, machineDescription: String
    let status: Bool
    let mtype: String
    let fese: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case machineDescription = "description"
        case status, mtype, fese
    }
}

typealias Machines = [Machine]
