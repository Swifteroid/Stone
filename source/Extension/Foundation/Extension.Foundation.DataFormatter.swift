import Foundation

extension DateFormatter
{
    /*
    Initialises formatter with a date format.
    */
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }

    public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}