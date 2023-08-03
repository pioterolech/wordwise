import XCTest
@testable import OpenAIClient

final class OpenAIClientTests: XCTestCase {
    var client: OpenAIClient!
    
    override func setUpWithError() throws {
        client = OpenAIFactory.create()
    }
    
    func testExample() async throws {
        let article = """
            Chef Black says that his refined version of run down is a dish that parallels his rise from his modest Jamaican roots to one of the biggest restaurant awards ceremonies in the US.

            "I didn't know what foraging and organic was, but I only ate that way [growing up], we just didn't know what it was called," said Black, who got into cooking via his grandmother. She taught him about foraging and cooking and even tasked Black with building an outdoor clay oven so the family could grill over open flames.

            After discovering how much he enjoyed cooking, Black moved to an adjacent village at the age of 14, where he worked in a hotel resort for two years as a kitchen porter, sleeping in the staff changing room. Black started by doing jobs like cleaning refrigerators and juicing more than 3,000 oranges per day. He eventually progressed to working in the resort kitchen, and his success there ultimately landed him at a culinary school in Ohio.

            A far cry from his initial resort cooking stint, Black then embarked on a culinary tour de force, clocking time at a Sandals Resort in Turks and Caicos, The Ritz in Paris and The Peabody in Memphis, Tennessee. He started working at The Skirvin Hotel in Oklahoma City in 2007.
        """
        
        let value = try await client.getDifficultWordsFromArticle(article: article)
        
        XCTAssertTrue(value.words.count > 0)
    }
}
