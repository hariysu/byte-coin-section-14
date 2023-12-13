//
//  CoinData.swift
//  Byte-Coin-Section-14
//
//  Created by Abdurahman on 12.12.2023.
//

import Foundation

struct CoinData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
