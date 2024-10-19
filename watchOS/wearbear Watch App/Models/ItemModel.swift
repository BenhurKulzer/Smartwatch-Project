import Foundation

struct ItemModel: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    
    // Implementação de Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }

    // Implementação de Equatable (gerada automaticamente)
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
