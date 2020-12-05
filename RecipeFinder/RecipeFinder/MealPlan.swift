//
//  MealPlan.swift
//  RecipeFinder
//
//  Created by Jimmy Ren on 12/4/20.
//

import Foundation


struct MealPlan {
    var week: Array<DayPlan>;
    init() {
        week = Array()
        for i in 0...6 {
            week.append(DayPlan.init(i: i))
        }
    }
    mutating func resetWeek() {
        week = Array()
        for i in 0...6 {
            week.append(DayPlan.init(i: i))
        }
    }
    mutating func addMeal(day: Int, m: Meal) {
        week[day].Meals.append(m)
    }
}

struct DayPlan {
    var Meals = Array<Meal>()
    let nameOfDay: DayOfWeek
    init(i: Int) {
        nameOfDay = DayOfWeek(rawValue: i)!
        Meals = Array<Meal>()
    }
    mutating func resetDay() {
        Meals = Array<Meal>()
    }
}

enum DayOfWeek: Int {
    case Sunday = 0
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

struct Meal {
    var label: String
    var image: String
    var source: String
    var url: String
    var mealtime: MealTime
}

enum MealTime: Int {
    case Breakfast = 0
    case Lunch
    case Dinner
}
