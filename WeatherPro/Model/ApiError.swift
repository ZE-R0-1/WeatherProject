//
//  ApiError.swift
//  WeatherPro
//
//  Created by 윤준영 on 2023/07/03.
//

import Foundation

enum ApiError: Error {
    case unknown
    case invaildUrl(String)
    case invaildResponse
    case failed(Int)
    case emptyData
}
