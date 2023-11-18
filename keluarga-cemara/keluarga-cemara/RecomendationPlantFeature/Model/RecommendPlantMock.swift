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
        title: "Bokcoy",
        description: "Bok Choy, also known as Chinese cabbage, is a popular leafy green vegetable that is not only delicious but also packed with several health benefits such as nutrient rich, low in calories, antioxidant properties, heart health and bone health.",
        image: .bokcoy,
        type: .partialshade,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "3-5 hours of sunlight a day."),
            PlantCareInfo(typeCareInfo: .watering, info: "About one inch of water a week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Needs nitrogen for leaf growth and phosphorus and potassium.")
        ])
    let spinachPlant = RecommendPlantModel(
        title: "Spinach",
        description: "Spinach is nutritious leafy that is rich in multiple vitamins and minerals. Benefits of consuming spinach include diabetes and asthma management, promotes digestive regularity, lowering the risk of cancer, lowering blood pressure, and improving bone health.",
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
        description: "Cabbage is rich in vitamin C, fiber, and vitamin K. They may help protect against radiation, prevent cancer, reduce heart disease risk and help with digestive health.",
        image: .cabbage,
        type: .partialsun,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "3-5 hours of sunlight a day."),
            PlantCareInfo(typeCareInfo: .watering, info: "Once a week, applying 1 1/2 inches of water to the soil."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Every three to four weeks until heads begin to form.")
        ])
    // partial sun plant
    let celeryPlant = RecommendPlantModel(
        title: "Celery",
        description: "Celery is an aromatic vegetable high in fiber and nutrients and low in calories. It is associated with reduced inflammation and reduced risk of cancer and heart disease, as well as contributing factors to type 2 diabetes.",
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
        description: "Pepper is low in calories and loaded with good nutrition. It is an antioxidant that provides anti-inflammatory and antimicrobial effects, among other health benefits. It may also boost brain function and increase levels of good cholesterol.",
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
        description: "Tomato is a great source of vitamin C, potassium, folate, and vitamin K. Consumption of tomatoes and tomato-based products has been linked to improved skin health and a lower risk of heart disease and cancer.",
        image: .tomato,
        type: .fullsun,
        plantCare: [
            PlantCareInfo(typeCareInfo: .sunlight, info: "8 hours of sunlight per day."),
            PlantCareInfo(typeCareInfo: .watering, info: "About 1-2 inches of water per week."),
            PlantCareInfo(typeCareInfo: .fertilization, info: "Every week or two throughout the flowering an fruiting season.")
        ])
    let endivePlant = RecommendPlantModel(
        title: "Endive",
        description: "Endive can dipanen setelah 40-60 hari setelah penanaman and has benefits such as good source of folate, may help prevent cancer, keeps heart healthy, helps maintain a healthy weight.",
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
