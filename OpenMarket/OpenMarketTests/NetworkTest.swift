//
//  NetworkTest.swift
//  OpenMarket
//
//  Created by 윤재웅 on 2021/05/21.
//

import XCTest
@testable import OpenMarket

class NetworkTest: XCTestCase {
    var mockItems: Data?
    var mockItem: Data?
    var mockDecode: MockDecoder?
    var mockClient: MockNetworkloader?
    
    override func setUpWithError() throws {
        mockItems = NSDataAsset(name: "Items")!.data
        mockItem = NSDataAsset(name: "Item")!.data
        mockDecode = MockDecoder()
        mockClient = MockNetworkloader()
    }

    override func tearDownWithError() throws {
        mockItems = nil
        mockItem = nil
        mockDecode = nil
        mockClient = nil
    }

    func test_network_excute_GET_성공() {
        mockClient?.resultToreturn = .success(mockItems!)
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.items(page: 1).url
        let request = URLRequest(url: url!)
        let expectation = XCTestExpectation(description: "GET 목록조회")
        
        sut.excute(request: request, decodeType: MarketItems.self) { (result: Result<MarketItems, Error>) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
    
    func test_network_excute_GET_실패() {
        mockClient?.resultToreturn = .failure(MarketError.get)
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.items(page: 1).url
        let request = URLRequest(url: url!)
        let expectation = XCTestExpectation(description: "GET 목록조회")
        
        sut.excute(request: request, decodeType: MarketItems.self) { (result: Result<MarketItems, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                XCTAssert(true)
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
    
    func test_network_excute_POST_상품등록_성공() {
        mockClient?.resultToreturn = .success(Data())
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.registrate.url
        let request = sut.createRequest(url: url, encodeBody: TestData.registrateData, method: .post)
        let result = try! request.get()
        let expectation = XCTestExpectation(description: "POST 상품등록")
        
        sut.excute(request: result!, decodeType: MarketItem.self) { (result: Result<MarketItem, Error>) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
    
    func test_network_excute_POST_상품등록_실패() {
        mockClient?.resultToreturn = .failure(MarketError.post)
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.registrate.url
        let request = sut.createRequest(url: url, encodeBody: TestData.registrateData, method: .post)
        let result = try! request.get()
        let expectation = XCTestExpectation(description: "POST 상품등록")
        
        sut.excute(request: result!, decodeType: MarketItem.self) { (result: Result<MarketItem, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                XCTAssert(true)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
    
    func test_network_excute_POST_상품삭제_성공() {
        mockClient?.resultToreturn = .success(Data())
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.delete(id: 1).url
        let request = sut.createRequest(url: url, encodeBody: TestData.password, method: .delete)
        let result = try! request.get()
        let expectation = XCTestExpectation(description: "POST 상품삭제")
        
        sut.excute(request: result!, decodeType: MarketItem.self) { (result: Result<MarketItem, Error>) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
    
    func test_network_excute_POST_상품삭제_실패() {
        mockClient?.resultToreturn = .failure(MarketError.delete)
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.delete(id: 1).url
        let request = sut.createRequest(url: url, encodeBody: TestData.password, method: .delete)
        let result = try! request.get()
        let expectation = XCTestExpectation(description: "POST 상품삭제")
        
        sut.excute(request: result!, decodeType: MarketItem.self) { (result: Result<MarketItem, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                XCTAssert(true)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }

    func test_network_excute_PATCH_상품수정_성공() {
        mockClient?.resultToreturn = .success(Data())
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.edit(id: 1).url
        let request = sut.createRequest(url: url, encodeBody: TestData.editData, method: .delete)
        let result = try! request.get()
        let expectation = XCTestExpectation(description: "PATCH 상품수정")
        
        sut.excute(request: result!, decodeType: MarketItem.self) { (result: Result<MarketItem, Error>) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
    
    func test_network_excute_PATCH_상품수정_실패() {
        mockClient?.resultToreturn = .failure(MarketError.patch)
        let sut = MarketNetworkManager(loader: mockClient!, decoder: mockDecode!)
        let url = MarketAPI.Path.edit(id: 1).url
        let request = sut.createRequest(url: url, encodeBody: TestData.editData, method: .delete)
        let result = try! request.get()
        let expectation = XCTestExpectation(description: "PATCH 상품수정")
        
        sut.excute(request: result!, decodeType: MarketItem.self) { (result: Result<MarketItem, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                XCTAssert(true)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockClient!.executeCalled)
    }
}
