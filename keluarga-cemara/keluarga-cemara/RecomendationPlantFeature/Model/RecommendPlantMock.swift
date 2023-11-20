//
//  RecommendPlantMock.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 25/10/23.
//

import Foundation

struct RecommendPlantMock{
    // partial shade plant
    let bokcoyPlant = RecommendPlantModel(
        title: "Bok Choy",
        description: "Bok Choy is a popular leafy green vegetable that offers several health benefits, including being nutrient-rich, low in calories, possessing antioxidant properties, and promoting heart and bone health. It can be harvested 120 days after planting.",
        image: .bokcoy,
        type: .partialshade,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "3-5 hours of sunlight a day."),
            PlantCareInfo(typeCareInfo: .watering, info: "About one inch of water a week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Needs nitrogen for leaf growth and phosphorus and potassium.")
        ])
    let spinachPlant = RecommendPlantModel(
        title: "Spinach",
        description: "Spinach is rich in multiple vitamins and minerals. It offers many benefits for diabetes and asthma management, reduces the risk of cancer, lowers blood pressure, and improves bone health. It can be harvested 120 days after planting.",
        image: .spinach,
        type: .partialshade,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "3-5 hours of sunlight a day."),
            PlantCareInfo(typeCareInfo: .watering, info: "Water several times a week about 1-2 inches."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Mix a fertilizer that's high in nitrogen into the soil.")
        ])
    // partial sun plant
    let cabbagePlant = RecommendPlantModel(
        title: "Cabbage",
        description: "Cabbage is rich in vitamin C, fiber, and vitamin K. It may help protect against radiation, prevent cancer, reduce heart disease risk and help with digestive health. It can be harvested 65 days after planting.",
        image: .cabbage,
        type: .partialsun,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "3-5 hours of sunlight a day."),
            PlantCareInfo(typeCareInfo: .watering, info: "Once a week, applying 1 1/2 inches of water to the soil."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Every 3 to 4 weeks until heads begin to form.")
        ])
    // partial sun plant
    let celeryPlant = RecommendPlantModel(
        title: "Celery",
        description: "Celery is an aromatic vegetable that is high in fiber and nutrients while being low in calories. It can reduce inflammation, lower the risk of cancer and heart disease, as well as address contributing factors to type 2 diabetes. It can be harvested 120 days after planting.",
        image: .celery,
        type: .partialsun,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "8 hours of sunlight per day."),
            PlantCareInfo(typeCareInfo: .watering, info: "About 1-2 inches of water per week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Every 3‐4 weeks with an all‐purpose granular or liquid fertilizer.")
        ])
    // full sun plant
    let pepperPlant = RecommendPlantModel(
        title: "Pepper",
        description: "Pepper is an antioxidant that provides anti-inflammatory and antimicrobial effects, among other health benefits. It may also boost brain function and increase levels of good cholesterol. It can be harvested 120 days after planting.",
        image: .pepper,
        type: .fullsun,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "6-8 hours of direct sunlight per day."),
            PlantCareInfo(typeCareInfo: .watering, info: "Once per week and aim for a total 1-2 inches per week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "About 1-2 weeks after the seeds have sprouted.")
        ])
    // full sun plant
    let tomatoPlant = RecommendPlantModel(
        title: "Tomato",
        description: "Tomato is a great source of vitamin C, potassium, folate, and vitamin K. Consuming tomatoes can improve skin health and lower the risk of heart disease and cancer. It can be harvested 90-120 days after planting.",
        image: .tomato,
        type: .fullsun,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "8 hours of sunlight per day."),
            PlantCareInfo(typeCareInfo: .watering, info: "About 1-2 inches of water per week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Every week or two throughout the flowering an fruiting season.")
        ])
    let endivePlant = RecommendPlantModel(
        title: "Endive",
        description: "Endive offers various health benefits, including being a good source of folate, potential cancer prevention, heart health support, weight management, and many more. It can be harvested after 40-60 days of planting.",
        image: .endive,
        type: .fullshade,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "2-3 hours of daily sun."),
            PlantCareInfo(typeCareInfo: .watering, info: "About 1-1.5 inches of water per week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Equal or near-equal amounts of nitrogen, phosphorus, and potassium.")
        ])
}

// MARK: static data access to mock data
extension RecommendPlantMock {
    static var plantMockData: [RecommendPlantModel] {
        return [
            RecommendPlantMock().bokcoyPlant,
            RecommendPlantMock().cabbagePlant,
            RecommendPlantMock().pepperPlant,
            RecommendPlantMock().spinachPlant,
            RecommendPlantMock().tomatoPlant,
            RecommendPlantMock().celeryPlant,
            RecommendPlantMock().endivePlant
        ]
    }
    
    static func separatePlantsByType(_ type: TypeOfPlant = .partialsun) -> [RecommendPlantModel] {
        var separatedPlants: [RecommendPlantModel] = []

        let allPlants = RecommendPlantMock.plantMockData

        for plant in allPlants {
            if plant.type == type{
                separatedPlants.append(plant)
            }
        }

        return separatedPlants
    }
}
