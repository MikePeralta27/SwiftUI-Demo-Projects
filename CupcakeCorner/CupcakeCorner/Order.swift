//
//  Order.swift
//  CupcakeCorner
//
//  Created by Michael Peralta on 5/4/26.
//

import Foundation

@Observable
class Order: Codable {

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "special_request_enabled"
        case _extraFrosting = "extra_frosting"
        case _extraSprinkles = "extra_sprinkles"
        case _name = "name"
        case _streetAddress = "street_address"
        case _city = "city"
        case _zip = "zip"
    }

    private struct SavedAddress: Codable {
        var name: String = ""
        var streetAddress: String = ""
        var city: String = ""
        var zip: String = ""
    }

    private static let savedAddressDefaultsKey =
        "CupcakeCorner.savedDeliveryAddress"

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled: Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var extraSprinkles = false

    /// Skip persistence while applying values loaded in `init()`.
    private var suppressAddressPersistence = false

    var name = "" {
        didSet { persistDeliveryAddressIfNeeded() }
    }
    var streetAddress = "" {
        didSet { persistDeliveryAddressIfNeeded() }
    }
    var city = "" {
        didSet { persistDeliveryAddressIfNeeded() }
    }
    var zip = "" {
        didSet { persistDeliveryAddressIfNeeded() }
    }

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if ![name, streetAddress, city, zip].allSatisfy({
            !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }) {
            return false
        }
        if name.count < 3 || streetAddress.count < 3 || city.count < 3
            || zip.count < 3
        {
            return false
        }
        return true
    }

    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(quantity) / 2

        // $1/ cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        if extraSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }

    init() {
        suppressAddressPersistence = true
        let saved = Self.loadSavedAddressFromDefaults()
        name = saved.name
        streetAddress = saved.streetAddress
        city = saved.city
        zip = saved.zip
        suppressAddressPersistence = false
    }

    private func persistDeliveryAddressIfNeeded() {
        guard !suppressAddressPersistence else { return }
        Self.saveAddressToDefaults(
            SavedAddress(
                name: name,
                streetAddress: streetAddress,
                city: city,
                zip: zip
            )
        )
    }

    private static func saveAddressToDefaults(_ address: SavedAddress) {
        if let data = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(
                data,
                forKey: Self.savedAddressDefaultsKey
            )
        }
    }

    private static func loadSavedAddressFromDefaults() -> SavedAddress {
        guard
            let data = UserDefaults.standard.data(
                forKey: Self.savedAddressDefaultsKey
            ),
            let decoded = try? JSONDecoder().decode(
                SavedAddress.self,
                from: data
            )
        else {
            return SavedAddress()
        }
        return decoded
    }
}
