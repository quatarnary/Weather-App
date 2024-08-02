//
//  LocationTestData.swift
//  Weather App
//
//  Created by Bugra Aslan on 21.06.2024.
//

import Foundation

let locationTestData: Data = """
[
    {
        "name": "Istanbul",
        "region": "Istanbul",
        "country": "Turkey",
        "lat": 41.02,
        "lon": 28.96,
        "tz_id": "Europe/Istanbul",
        "localtime_epoch": 1716893269,
        "localtime": "2024-05-28 13:47"
    },
    {
        "name": "Ankara",
        "region": "Ankara",
        "country": "Turkey",
        "lat": 39.93,
        "lon": 32.86,
        "tz_id": "Europe/Istanbul",
        "localtime_epoch": 1718996882,
        "localtime": "2024-06-21 22:08"
    },
    {
        "name": "Izmir",
        "region": "Izmir",
        "country": "Turkey",
        "lat": 38.41,
        "lon": 27.14,
        "tz_id": "Europe/Istanbul",
        "localtime_epoch": 1718996921,
        "localtime": "2024-06-21 22:08"
    }
]
""".data(using: .utf8)!
//
//let locationTestData: Data = """
//{
//    "location": [
//        {
//            "name": "Istanbul",
//            "region": "Istanbul",
//            "country": "Turkey",
//            "lat": 41.02,
//            "lon": 28.96,
//            "tz_id": "Europe/Istanbul",
//            "localtime_epoch": 1716893269,
//            "localtime": "2024-05-28 13:47"
//        },
//        {
//            "name": "Ankara",
//            "region": "Ankara",
//            "country": "Turkey",
//            "lat": 39.93,
//            "lon": 32.86,
//            "tz_id": "Europe/Istanbul",
//            "localtime_epoch": 1718996882,
//            "localtime": "2024-06-21 22:08"
//        },
//        {
//            "name": "Izmir",
//            "region": "Izmir",
//            "country": "Turkey",
//            "lat": 38.41,
//            "lon": 27.14,
//            "tz_id": "Europe/Istanbul",
//            "localtime_epoch": 1718996921,
//            "localtime": "2024-06-21 22:08"
//        }
//    ]
//}
//""".data(using: .utf8)!
