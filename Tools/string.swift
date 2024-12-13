/// Extracts values from a line of text using specified prefix and separator
/// - Parameters:
///   - line: The input line to process
///   - prefix: The prefix to remove from the line
///   - separator: The character used to separate values
/// - Returns: Array of substrings containing the extracted values
func extractValues(from line: String, prefix: String, separator: Character) -> [String.SubSequence]
{
    return line.replacingOccurrences(of: prefix, with: "").split(separator: separator)
}

/// Extracts an integer value from a substring after a separator
/// - Parameters:
///   - line: The input substring to process
///   - separator: The character that separates the label from the value
/// - Returns: The extracted integer value, or 0 if extraction fails
func extractIntValue(from line: String.SubSequence, separator: Character) -> Int {
    let components = line.split(separator: separator)
    guard components.count > 1 else {
        return 0
    }
    return Int(String(components[1]).trimmingCharacters(in: .whitespaces))!
}

/// Extracts a string value from a substring after a separator
/// - Parameters:
///   - line: The input substring to process
///   - separator: The character that separates the label from the value
/// - Returns: The extracted string value
func extractStringValue(from line: String.SubSequence, separator: Character) -> String {
    return line.split(separator: separator)[1].trimmingCharacters(in: .whitespaces)
}
