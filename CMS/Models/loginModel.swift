//
//  loginModel.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import Foundation

// MARK: - LogInModel
struct LogInModel: Codable {
    let username: String
    let authorities: [Authority]
    let accessToken, tokenType: String
}

// MARK: - Authority
struct Authority: Codable {
    let authority: String
}
