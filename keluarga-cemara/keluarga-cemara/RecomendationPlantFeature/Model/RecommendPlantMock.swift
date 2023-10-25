//
//  RecommendPlantMock.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 25/10/23.
//

import Foundation

struct RecommendPlantMock{
    let plantOne = RecommendPlantModel(
        title: "Plant one",
        description: "This is plant description with benefit that you can try it in home also can detach it to another plant",
        image: .pakcoy,
        type: .fullsun,
        plantCare: [
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about")
        ])
    
    let plantTwo = RecommendPlantModel(
        title: "Plant two",
        description: "This is plant description with benefit that you can try it in home also can detach it to another plant",
        image: .pakcoy,
        type: .fullsun,
        plantCare: [
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about")
        ])
    
    let plantThree = RecommendPlantModel(
        title: "Plant three",
        description: "This is plant description with benefit that you can try it in home also can detach it to another plant",
        image: .pakcoy,
        type: .partialsun,
        plantCare: [
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about")
        ])
    
    let plantFour = RecommendPlantModel(
        title: "Plant four",
        description: "This is plant description with benefit that you can try it in home also can detach it to another plant",
        image: .pakcoy,
        type: .partialsun,
        plantCare: [
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about"),
            PlantCareInfo(image: "drop.fill", info: "this is info plant that you want to know about")
        ])
}

// MARK: static data access to mock data
extension RecommendPlantMock {
    static var plantMockData: [RecommendPlantModel] {
        return [RecommendPlantMock().plantOne, RecommendPlantMock().plantTwo, RecommendPlantMock().plantThree, RecommendPlantMock().plantFour]
    }
    
    static func separatePlantsByType() -> [typeOfPlant: [RecommendPlantModel]] {
        var separatedPlants: [typeOfPlant: [RecommendPlantModel]] = [:]

        let allPlants = RecommendPlantMock.plantMockData

        for plant in allPlants {
            if separatedPlants[plant.type] == nil {
                separatedPlants[plant.type] = []
            }
            separatedPlants[plant.type]?.append(plant)
        }

        return separatedPlants
    }
}
