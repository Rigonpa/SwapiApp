//
//  MyFirstTest.swift
//  SwapiAppTests
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest

@testable import SwapiApp
class MyFirstTest: XCTestCase {
    /*
     On this test listInteractor will be examined:
     I am specifically proving that listInteractor calls
     loadCharacters() from NetworkManager class,
     receives both good and bad responses from it and comunicate them
     to the presenter adequately.
     
     I create a mockPresenter class for enable boolean variables required for the XCTAssets
     I create two mockNetworkManager classes for sending specific good and bad response (to test
      both cases) of the api request to interactor in the closure of loadCharacters()
      in MockNetworkManager class.
     */
    
    var testingInteractor: ListInteractor!
    var mockPresenter: MockPresenter!
    
    override func setUp() {
        super.setUp()
        testingInteractor = ListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_getCharacters_SuccessResponse_ShouldGoSuccessMethod () {
        
        // GIVEN
        mockPresenter = MockPresenter()
        let mockNetworkManager = MockSuccessNetworkManager()
        testingInteractor.presenter = mockPresenter
        testingInteractor.networkManager = mockNetworkManager
        
        // WHEN
        testingInteractor.loadCharacters()
        
        // THEN
        XCTAssertTrue(self.mockPresenter.charactersOk)
        XCTAssertEqual(self.mockPresenter.charactersList.count, 3)
    }
    
    func test_getAllCharacters_FailureResponse_ShouldGoErrorMethod () {
        
        // GIVEN
        mockPresenter = MockPresenter()
        testingInteractor.presenter = mockPresenter
        testingInteractor.networkManager = MockErrorNetworkManager()
        
        // WHEN
        testingInteractor.loadCharacters()
        
        // THEN
        XCTAssertTrue(self.mockPresenter.charactersError)
        XCTAssertEqual(self.mockPresenter.charactersList.count, 0)
    }
    
    
}

class MockPresenter: ListInteractorOutput {
    
    var charactersOk: Bool = false
    var charactersList = [CharacterData]()
    var charactersError: Bool = false
    
    func charactersDownloaded(charactersList: [CharacterData]) {
        self.charactersList = charactersList
        charactersOk = true
    }
    
    func charactersRequestFailed(message: String) {
        charactersError = true
    }
}

class MockErrorNetworkManager: NetworkManagerProtocol {
    func loadCharacters(completion: @escaping (Result<[CharacterData], MyError>) -> Void) {
        completion(.failure(MyError(message: "We are gonna shout it loud, you are unbreakable")))
    }
}

class MockSuccessNetworkManager: NetworkManagerProtocol {
    let characterData = CharacterData(name: "TestName",
                                      height: "TestHeight",
                                      mass: "TestMass",
                                      hairColor: "TestHairColor",
                                      skinColor: "TestSkinColor",
                                      eyeColor: "TestEyeColor",
                                      birthYear: "TestBirthYear",
                                      gender: .male,
                                      homeworld: "TestHomeworld",
                                      films: [],
                                      species: [],
                                      vehicles: [],
                                      starships: [],
                                      created: "TestCreated",
                                      edited: "TestEdited",
                                      url: "TestUrl")
    
    func loadCharacters(completion: @escaping (Result<[CharacterData], MyError>) -> Void) {
        completion(.success([characterData, characterData, characterData]))
    }
}
