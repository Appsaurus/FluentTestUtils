import Foundation
import XCTest
import Fluent
import CodableExtensions
import XCTVaporExtensions

public func XCTAssert<R>(query: QueryBuilder<R>, hasCount count: Int) {
	XCTAssertEqual(try query.count().wait(), count)
}

public func XCTAssert<M: Model>(model: M.Type, hasCount count: Int, on db: Database){
	XCTAssert(query: M.query(on: db), hasCount: count)
}
public func XCTAssertJSONEqual(source: Encodable, candidates: Encodable...) {
	XCTAssert(jsonIsEqual(source: source, candidates: candidates))
}

public func XCTAssertJSONNotEqual(source: Encodable, candidates: Encodable...) {
	XCTAssertFalse(jsonIsEqual(source: source, candidates: candidates))
}

public func jsonIsEqual(source: Encodable, candidates: [Encodable]) -> Bool{
	let sourceString = try! source.encodeAsJSONString()
	return !candidates.contains(where: {try! $0.encodeAsJSONString() != sourceString})
}

public func XCTAssertReferencingSameEntity<RE: Model>(_ target: RE, 
                                                      _ testCandidates: RE...) where RE.IDValue: Comparable {
	testCandidates.forEach { (testCandidate) in
		XCTAssert(target.isReferencingSameEntity(as: testCandidate))
	}
}

public func XCTAssertAllReferencingSameEntity<RE: Model>(_ target: [RE],
                                                         _ testCandidate: [RE]) where RE.IDValue: Comparable {
		XCTAssert(target.areReferencingSameEntities(as: testCandidate))
}


extension Collection where Element: Model, Element.IDValue: Comparable {
	public func areReferencingSameEntities(as otherEntities: Self) -> Bool{
        return hasEqualValues(at: \Element.id, as: otherEntities)
	}
}

extension Model {
	public func isReferencingSameEntity(as entityReference: Self) -> Bool {
        return self.id == entityReference.id
	}
}

//TODO: Refactor into general Swift library
extension Collection{
	public func values<C: Comparable>(at keyPath: KeyPath<Element, C>) -> [C]{
		return self.map({$0[keyPath: keyPath]})
	}
	public func sortedValues<C: Comparable>(at keyPath: KeyPath<Element, C>) -> [C]{
		return values(at: keyPath).sorted()
	}
	public func sortedValues<C: Comparable>(at keyPath: KeyPath<Element, C>, by sorter: (C, C) throws -> Bool) throws -> [C]{
		return try values(at: keyPath).sorted(by: sorter)
	}

	public func hasEqualValues<C: Comparable>(at keyPath: KeyPath<Element, C>, as otherCollection: Self) -> Bool{
		let targetSorted = sortedValues(at: keyPath)
		let candidateSorted = otherCollection.sortedValues(at: keyPath)
		guard targetSorted.count == candidateSorted.count else { return false }
		for (index, target) in targetSorted.enumerated(){
			guard target == candidateSorted[index] else { return false }
		}
		return true
	}

	//Optional value KeyPaths
	public func values<C: Comparable>(at keyPath: KeyPath<Element, C?>) -> [C]{
		return self.map({$0[keyPath: keyPath]}).compactMap({$0})
	}

	public func sortedValues<C: Comparable>(at keyPath: KeyPath<Element, C?>) -> [C]{
		return values(at: keyPath).sorted()
	}

	public func hasEqualValues<C: Comparable>(at keyPath: KeyPath<Element, C?>, as otherCollection: Self) -> Bool{
		return self.values(at: keyPath).containsSameElements(as: otherCollection.values(at: keyPath))
	}
}

extension Collection where Element: Comparable{
	public func containsSameElements(as other: Self) -> Bool {
		return self.count == other.count && self.sorted() == other.sorted()
	}
}
