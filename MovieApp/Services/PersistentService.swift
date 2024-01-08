//
//  PersistentService.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import UIKit

struct WishlistItem: Codable, Hashable {
    let addDate: Date
    let id: Int
}

protocol PersistentServiceProtocol {
    func getWishlist() -> [WishlistItem]
    func addToWishlist(_ id: Int)
    func removeFromWishlist(_ id: Int)
}

final class PersistentService: PersistentServiceProtocol {
    
    private var wishlist = Set<WishlistItem>()
    
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var filepath: URL {
        documentsDirectory.appendingPathComponent("wishlist.json")
    }
    
    init() {
        loadWishlist()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveWishlist), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    deinit {
        saveWishlist()
    }
    
    func getWishlist() -> [WishlistItem] {
        wishlist.sorted(by: { $0.addDate < $1.addDate })
    }
    
    func addToWishlist(_ id: Int) {
        wishlist.insert(.init(addDate: .now, id: id))
    }
    
    func removeFromWishlist(_ id: Int) {
        guard let item = wishlist.first(where: { $0.id == id }) else {
            return
        }
        wishlist.remove(item)
    }
    
    private func loadWishlist() {
        guard let data = try? Data(contentsOf: filepath) else {
            print("failed to read data")
            return
        }
        
        guard let wishlist = try? JSONDecoder().decode(Set<WishlistItem>.self, from: data) else {
            print("failed to decode wishlist")
            return
        }
        self.wishlist = wishlist
    }
    
    @objc
    private func saveWishlist() {
        guard let data = try? JSONEncoder().encode(wishlist) else {
            print("failed to encode wishlist")
            return
        }
        do {
            try data.write(to: filepath)
        } catch {
            print("failed to save wishlist")
        }
    }
}
