//
//  HTTPDataDownloader.swift
//  Weather App
//
//  Created by Bugra Aslan on 23.05.2024.
//

import Foundation

let validStatus = 200...299

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        let r: (Data, HTTPURLResponse)?

        do {
            r = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse)
        } catch (let e) {
            throw CustomErrors.HTTPDataDownloaderError("Couldn't send request.", e)
        }
        guard let (data, response) = r else {
            throw CustomErrors.HTTPDataDownloaderError("There is something wrong with data.")
        }
        if !validStatus.contains(response.statusCode) {
            throw CustomErrors.HTTPDataDownloaderError("There is something wrong with status code. \(response.statusCode)")
        }

        return data
    }
}
