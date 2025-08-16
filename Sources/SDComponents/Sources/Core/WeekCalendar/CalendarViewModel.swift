import Foundation

public final class CalendarViewModel: ObservableObject {
    private let calendar = Calendar.current
    @Published public var selectedDate: Date
    @Published var weeks: [WeekModel] = []

    public init() {
        let today = calendar.startOfDay(for: Date())
        selectedDate = today

        // Start with 10 weeks in the past + current week
        var tempWeeks: [WeekModel] = []
        _ = today.currentWeek

        // Add current week at the end
        tempWeeks.append(WeekModel(dates: today.currentWeek))

        // Prepend past weeks
        for i in 1...10 {
            let prevWeek = today.addingTimeInterval(TimeInterval(-7 * 24 * 60 * 60 * i)).currentWeek
            tempWeeks.insert(WeekModel(dates: prevWeek), at: 0)
        }

        weeks = tempWeeks
    }

    func isDateSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }

    func loadMorePastWeeks() {
        if let firstDate = weeks.first?.dates.first {
            var newWeeks: [WeekModel] = []
            for i in 1...10 {
                let prevWeek = firstDate.addingTimeInterval(TimeInterval(-7 * 24 * 60 * 60 * i)).currentWeek
                newWeeks.insert(WeekModel(dates: prevWeek), at: 0)
            }
            weeks.insert(contentsOf: newWeeks, at: 0)
        }
    }
}
