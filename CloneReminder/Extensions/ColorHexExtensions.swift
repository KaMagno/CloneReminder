import SwiftUI

extension Color {
    /// Create a Color from a hex string.
    /// Supports the following formats (with or without leading `#` or `0x`):
    /// - RGB (e.g., "#F0A")
    /// - RRGGBB (e.g., "#FF00AA")
    /// - AARRGGBB (e.g., "#CCFF00AA")
    /// If alpha is not specified, it defaults to 1.0.
    public init?(hex: String) {
        // Remove white spaces and lines.
        var whiteSpaceTrimmed: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Remove non-hex prefix characters like '#' or '0x'
        var nonPrefixHex: String = whiteSpaceTrimmed.replacingOccurrences(
            of: "0x",
            with: "",
            options: [.caseInsensitive]
        )
            
        if nonPrefixHex.hasPrefix("#") {
            nonPrefixHex.removeFirst()
        }
        
        var clearedHexString = nonPrefixHex

        // Expand shorthand RGB (Red Gren Blue) like F0A -> FF00AA
        if clearedHexString.count == 3 {
            let chars = Array(clearedHexString)
            clearedHexString = String([chars[0], chars[0], chars[1], chars[1], chars[2], chars[2]])
        }

        // Transform the String using Scanner
        let scanner = Scanner(string: clearedHexString)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { return nil }

        //Extract colors from Hex number
        var redPosition: Int = 16
        var greenPosition: Int = 8
        var bluePosition: Int = 0
        
        var redMask: UInt64 = 0xFF0000
        var greenMask: UInt64 = 0x00FF00
        var blueMask: UInt64 = 0x0000FF
        
        var maskedRed: UInt64
        var maskedGreen: UInt64
        var maskedBlue: UInt64
        var maskedAlpha: UInt64
        
        var extractedRed: UInt64
        var extractedGreen: UInt64
        var extractedBlue: UInt64
        var extractedAlpha: UInt64 = 0xFF //1.0
        
        //Function to let the code more readable.
        func apply(mask: UInt64, to hex: UInt64) -> UInt64 {
            hex & mask
        }
        
        func extractColor(ofHex hex: UInt64, fromPosition position: Int) -> UInt64 {
            hex >> position
        }
        
        //Change AARGB to RGB, if needed.
        if clearedHexString.count == 8 {
            let alphaMask: UInt64 = 0xFF000000
            let alphaPosition: Int = 24
            
            let argb = hexNumber
            maskedAlpha = apply(mask: alphaMask, to: argb)
            extractedAlpha = extractColor(ofHex: maskedAlpha, fromPosition: alphaPosition)
            
            hexNumber = argb & 0x00FFFFFF
        }
        
        //Apply Mask on each part of Hex so we hide uneed parts of it.
        maskedRed = apply(mask: redMask, to: hexNumber)
        maskedGreen = apply(mask: greenMask, to: hexNumber)
        maskedBlue = apply(mask: blueMask, to: hexNumber)
        
        //Extract the color hex of the whole hex.
        extractedRed = extractColor(ofHex: maskedRed, fromPosition: redPosition)
        extractedGreen = extractColor(ofHex: maskedGreen, fromPosition: greenPosition)
        extractedBlue = extractColor(ofHex: maskedBlue, fromPosition: bluePosition)
        
        //Transform into CGFloat
        let red: CGFloat = CGFloat(extractedRed) / 255.0
        let green: CGFloat = CGFloat(extractedGreen) / 255.0
        let blue: CGFloat = CGFloat(extractedBlue) / 255.0
        let alpha: CGFloat = CGFloat(extractedAlpha) / 255.0

        //Create the color
        self = Color(
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }

    /// Convenience factory that falls back to a default color when parsing fails.
    public static func fromHex(_ hex: String) -> Color? {
        Color(hex: hex)
    }

    /// Convert this Color to a hex string.
    /// - Parameters:
    ///   - includeAlpha: When true, returns `#AARRGGBB`; otherwise `#RRGGBB`.
    /// - Returns: A hex string representation or nil if components can't be extracted.
    public func toHexString(includeAlpha: Bool = false) -> String? {
        // Prefer platform color bridging directly
        #if canImport(UIKit)
        let platformColor = UIColor(self)
        let cg = platformColor.resolvedColor(with: UITraitCollection.current).cgColor
        #elseif canImport(AppKit)
        let platformColor = NSColor(self)
        guard let cg = platformColor.usingColorSpace(.sRGB)?.cgColor else { return nil }
        #else
        guard let cg = self.cgColor else { return nil }
        #endif

        // Ensure sRGB color space for consistent component ordering
        let sRGBSpace = CGColorSpace(name: CGColorSpace.sRGB)!
        let rgbColor = cg.converted(to: sRGBSpace, intent: .defaultIntent, options: nil) ?? cg

        guard let components = rgbColor.components else { return nil }

        let r, g, b, a: CGFloat
        switch components.count {
        case 4: // [r, g, b, a]
            r = components[0]
            g = components[1]
            b = components[2]
            a = components[3]
        case 2: // [white, alpha]
            r = components[0]
            g = components[0]
            b = components[0]
            a = components[1]
        case 3: // [r, g, b]
            r = components[0]
            g = components[1]
            b = components[2]
            a = 1.0
        default:
            return nil
        }

        let redInt = Int(round(r * 255))
        let greenInt = Int(round(g * 255))
        let blueInt = Int(round(b * 255))
        let alphaInt = Int(round(a * 255))

        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", alphaInt, redInt, greenInt, blueInt)
        } else {
            return String(format: "#%02X%02X%02X", redInt, greenInt, blueInt)
        }
    }
}
