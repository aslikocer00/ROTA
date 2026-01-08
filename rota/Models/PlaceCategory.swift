import Foundation

enum PlaceCategory: String, CaseIterable, Identifiable {
    case restaurant = "Restoran"
    case cafe = "Kafe"
    case bar = "Bar"
    case rooftop = "Rooftop"
    case meyhane = "Meyhane"
    case breakfast = "Kahvaltı"
    case brunch = "Brunch"
    case dessert = "Tatlı"
    case coffee = "Kahve"
    case teaHouse = "Çay Evi"
    case roastery = "Kavurmahane"
    case cozy = "Sıcak"
    case nostalgic = "Nostaljik"
    case fineDining = "Fine Dining"
    case bakery = "Pastane"
    case creative = "Yaratıcı"
    case modernTurkish = "Modern Türk"
    case modernAnatolian = "Modern Anadolu"
    case bistro = "Bistro"
    case ocakbasi = "Ocakbaşı"
    case traditional = "Geleneksel"
    case pasta = "Makarna"
    case cocktailBar = "Kokteyl Barı"
    case chefTable = "Chef’s Table"
    case fireCooking = "Açık Ateş"
    case intimate = "Butik"
    case fusion = "Fusion"
    case italian = "İtalyan"
    case wineBar = "Şarap Barı"
    case farmToTable = "Farm to Table"
    case mediterranean = "Akdeniz"

    var id: String { rawValue }
}

enum PriceLevel: String, CaseIterable, Identifiable {
    case affordable = "₺"
    case mid = "₺₺"
    case premium = "₺₺₺"
    case luxury = "₺₺₺₺"

    var id: String { rawValue }
}

enum Area: String, CaseIterable, Identifiable {
    case besiktas = "Beşiktaş"
    case beyoglu = "Beyoğlu"
    case nisantasi = "Nişantaşı"
    case karakoy = "Karaköy"
    case moda = "Moda"
    case arnavutkoy = "Arnavutköy"
    case sishane = "Şişhane"
    case kadikoy = "Kadıköy"
    case sisli = "Şişli"
    case balat = "Balat"
    case sariyer = "Sarıyer"
    case sile = "Şile"
    case maslak = "Maslak"
    case kozyatagi = "Kozyatağı"
    case fatih = "Fatih"
    case atasehir = "Ataşehir"
    case maltepe = "Maltepe"
    case bagcilar = "Bağcılar"
    case bakirkoy = "Bakırköy"
    case umraniye = "Ümraniye"

    var id: String { rawValue }
}
