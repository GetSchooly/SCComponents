import Foundation

public final class CalendarViewModel: ObservableObject {
    private let calendar = Calendar.current
    public var selectedDate: Date
    @Published var selectedWeekIndex = 1
    var currentWeeks: [WeekModel]
    
    public init() {
        let today = calendar.startOfDay(for: Date())
        selectedDate = today
        currentWeeks = [
            WeekModel(dates: today.previousWeek),
            WeekModel(dates: today.currentWeek)
        ]
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    func addNeededWeek() {
        if selectedWeekIndex == 0 {
            guard let someDate = currentWeeks.first?.dates.first else { return }
            let weekToAdd = someDate.previousWeek
            currentWeeks.insert(WeekModel(dates: weekToAdd), at: 0)
            currentWeeks.removeLast()
            selectedWeekIndex = 1
        } else if selectedWeekIndex == 2 {
            guard let someDate = currentWeeks.last?.dates.first else { return }
            let weekToAdd = someDate.nextWeek
            currentWeeks.append(WeekModel(dates: weekToAdd))
            currentWeeks.removeFirst()
            selectedWeekIndex = 1
        }
    }
    
    func updateSelectedDate() {
        if let index = currentWeeks.first?.dates.firstIndex(of: selectedDate) {
            selectedDate = currentWeeks[selectedWeekIndex].dates[index]
        } else if let index = currentWeeks.last?.dates.firstIndex(of: selectedDate) {
            selectedDate = currentWeeks[selectedWeekIndex].dates[index]
        }
    }
}
