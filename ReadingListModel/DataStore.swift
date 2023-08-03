// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation
import Combine

final class DataStore
{
    static let defaultStoreName = "ReadingList"
    let storeName: String
    let storeType = "json"
    
    var bundle: Bundle
    
    var documentsDirectoryUrl: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var storeFileUrl: URL {
        documentsDirectoryUrl.appendingPathComponent(storeName).appendingPathExtension(storeType)
    }
    var templateStoreFileUrl: URL {
        bundle.url(forResource: storeName, withExtension: storeType)!
    }
    
    init(storeName: String = defaultStoreName, bundle: Bundle = Bundle.main) {
        self.storeName = storeName
        self.bundle = bundle
        copyStoreFileIfNecessary()
    }
    
    func copyStoreFileIfNecessary() {
        if !FileManager.default.fileExists(atPath: storeFileUrl.path) {
            try! FileManager.default.copyItem(at: templateStoreFileUrl, to: storeFileUrl)
        }
    }
}

// MARK: - File-based operations

private let decoder = JSONDecoder()
private let encoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    return encoder
}()

enum StoreError: Error {
    case unableToEncode(message: String)
    case unableToDecode(message: String)
    case unableToSave(message: String)
}

extension DataStore {
    
    func fetch() throws -> ReadingList {
        guard
            let data = try? Data(contentsOf: storeFileUrl),
            let readingList = try? decoder.decode(ReadingList.self, from: data) else {
            throw StoreError.unableToDecode(message: "Unable to decode ReadingList at url \(storeFileUrl)")
        }
        return readingList
    }
    
    func save(readingList: ReadingList) throws {
        guard let data = try? encoder.encode(readingList) else {
            throw StoreError.unableToEncode(message: "Unable to encode \(readingList)")
        }
        
        do {
            try data.write(to: storeFileUrl)
        } catch {
            throw StoreError.unableToSave(message: "Unable to write to \(storeFileUrl), error was \(error)")
        }
    }
}

// MARK: - Async operations

private var subscriptions: Set<AnyCancellable> = []

extension DataStore {
    
    func fetchWithCombine(callback: @escaping (ReadingList) -> Void) throws -> Void {
        
        subscriptions.removeAll()
        
        URLSession.shared.dataTaskPublisher(for: storeFileUrl)
            .map { data, response -> Data in
                data
            }
            .decode(type: ReadingList.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { readingList in
                callback(readingList)
            }
            .store(in: &subscriptions)
    }
    
    @MainActor func fetchWithAsyncAwait() async throws -> ReadingList {
        let (data, _) = try await URLSession.shared.data(from: storeFileUrl)
        return try decoder.decode(ReadingList.self, from: data)
    }
}

