import Foundation
import Models

// MARK: - Program DTO Model

struct ProgramDTO: Codable {
    let harmonogram: [[Harmonogram]]
    let dates: [[String: String]]
}

// MARK: Harmonogram

struct Harmonogram: Codable {
    let id, od, harmonogramDo, nazev: String

    enum CodingKeys: String, CodingKey {
        case id, od
        case harmonogramDo = "do"
        case nazev
    }
}

// MARK: - To Model Conversion

extension ProgramDTO: DTOModelProtocol {
    var toModel: [Event] {
        var result: [Event] = []
        var idx = 0

        for day in self.harmonogram {
            for event in day {
                let date = self.dates[idx][String(idx)] ?? "no date"

                result.append(
                    Event(
                        id: event.id,
                        name: event.nazev,
                        startTime: event.od,
                        endTime: event.harmonogramDo,
                        date: date
                    )
                )
            }

            idx = idx + 1
        }

        return result
    }
}