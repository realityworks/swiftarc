//
//  Formatting.swift
//

import Foundation

extension Measurement {
    func formatted(
        fractionalDigits: Int,
        showPositiveSymbol: Bool = false,
        removeSuffixWhiteSpace: Bool = false
    ) -> String {
        let formatter = MeasurementFormatter()

        if showPositiveSymbol {
            formatter.numberFormatter.positivePrefix = formatter.numberFormatter.plusSign
        }

        formatter.numberFormatter.minimumFractionDigits = fractionalDigits
        formatter.numberFormatter.maximumFractionDigits = fractionalDigits
        formatter.numberFormatter.roundingMode = .halfUp

        if removeSuffixWhiteSpace {
            return formatter.string(from: self).replacingOccurrences(of: " ", with: "")
        }
        
        return formatter.string(from: self)
    }
}

extension Measurement where UnitType == UnitDuration {
    func formattedHoursWithMinutes() -> String {
        let formatter = MeasurementFormatter()

        let hoursValue = floor(Double(Int(self.converted(to: .seconds).value) / 60))
        let hoursMeasurement = Measurement(
            value: hoursValue,
            unit: .hours
        )

        let minutesRemainingValue = Double(Int(self.converted(to: .seconds).value) % 60)
        let minutesRemainingMeasurement = Measurement(
            value: minutesRemainingValue,
            unit: .minutes
        )

        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit

        let hoursString = formatter.string(from: hoursMeasurement)
        let minutesString = formatter.string(from: minutesRemainingMeasurement)

        return "\(hoursString) \(minutesString)"
    }
}

