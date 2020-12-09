//
//  NTESListDiffTestCase.m
//  ExampleTests
//
//  Created by amao on 2018/7/3.
//  Copyright © 2018年 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NTESFoundation/NTESFoundation.h>

static NSArray *sorted(NSArray *arr) {
    return [arr sortedArrayUsingSelector:@selector(compare:)];
}

#define NTESAssertContains(collection, object) do {\
id haystack = collection; id needle = object; \
XCTAssertTrue([haystack containsObject:needle], @"%@ does not contain %@", haystack, needle); \
} while(0)


@interface NSNumber (NTESListDiff)
@end

@implementation NSNumber(NTESListDiff)
- (NSString *)diffableHash
{
    return [self stringValue];
}
@end



@interface NTESListDiffTestCase : XCTestCase

@end

@implementation NTESListDiffTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_whenDiffingFromEmptyArray_thatResultHasChanges {
    NSArray *o = @[];
    NSArray *n = @[@1];
    NTESListDiffResult *result = NTESListDiff(o, n, 1);
    XCTAssertEqualObjects(result.inserts.firstObject, [NSIndexPath indexPathForRow:0 inSection:1]);
    XCTAssertEqual([result changeCount], 1);
}

- (void)test_whenDiffingToEmptyArray_thatResultHasChanges {
    NSArray *o = @[@1];
    NSArray *n = @[];
    NTESListDiffResult *result = NTESListDiff(o, n, 1);
    XCTAssertEqualObjects(result.deletes.firstObject, [NSIndexPath indexPathForRow:0 inSection:1]);
    XCTAssertEqual([result changeCount], 1);
}

- (void)test_whenSwappingObjects_thatResultHasMoves {
    NSArray *o = @[@1, @2];
    NSArray *n = @[@2, @1];
    NTESListDiffResult *result = NTESListDiff(o, n, 1);
    
    NTESListDiffMove *move = [[NTESListDiffMove alloc] initWithFrom:[NSIndexPath indexPathForRow:0 inSection:1]
                                                                 to:[NSIndexPath indexPathForItem:1 inSection:1]];
    
    NTESListDiffMove *move1 = [[NTESListDiffMove alloc] initWithFrom:[NSIndexPath indexPathForRow:1 inSection:1]
                                                                 to:[NSIndexPath indexPathForItem:0 inSection:1]];
    NSArray *expected = @[move,move1];
    NSArray<NTESListDiffMove *> *sortedMoves = sorted(result.moves);
    XCTAssertEqualObjects(sortedMoves, expected);
    XCTAssertEqual([result changeCount], 2);
}

- (void)test_whenMovingObjectsTogether_thatResultHasMoves {
    // "trick" is having multiple @3s
    NSArray *o = @[@1, @2, @3, @4];
    NSArray *n = @[@2, @3, @1, @4];
    NTESListDiffResult *result = NTESListDiff(o, n, 1);
    {
        NTESListDiffMove *move = [[NTESListDiffMove alloc] initWithFrom:[NSIndexPath indexPathForRow:1 inSection:1]
                                                                     to:[NSIndexPath indexPathForRow:0 inSection:1]];
        NTESAssertContains(result.moves, move);
    }
    
    {
        NTESListDiffMove *move = [[NTESListDiffMove alloc] initWithFrom:[NSIndexPath indexPathForRow:0 inSection:1]
                                                                     to:[NSIndexPath indexPathForRow:2 inSection:1]];
        NTESAssertContains(result.moves, move);
    }
}

- (void)test_whenDeletingItems_withInserts_withMoves_thatResultHasInsertsMovesAndDeletes {
    NSArray *o = @[@0, @1, @2, @3, @4, @5, @6, @7, @8];
    NSArray *n = @[@0, @2, @3, @4, @7, @6, @9, @5, @10];
    NTESListDiffResult *result = NTESListDiff(o, n, 1);
    
    NSArray *expectedDeletes = @[[NSIndexPath indexPathForRow:1 inSection:1],
                                 [NSIndexPath indexPathForRow:8 inSection:1]];
    NSArray *expectedInserts = @[[NSIndexPath indexPathForRow:6 inSection:1],
                                 [NSIndexPath indexPathForRow:8 inSection:1]];
    NSMutableArray *expectedMoves = [NSMutableArray array];
    {
        NSIndexPath *from = [NSIndexPath indexPathForRow:4 inSection:1];
        NSIndexPath *to = [NSIndexPath indexPathForRow:7 inSection:1];
        NTESListDiffMove *move = [[NTESListDiffMove alloc] initWithFrom:from
                                                                     to:to];
        [expectedMoves addObject:move];
    }
    {
        NSIndexPath *from = [NSIndexPath indexPathForRow:7 inSection:1];
        NSIndexPath *to = [NSIndexPath indexPathForRow:4 inSection:1];
        NTESListDiffMove *move = [[NTESListDiffMove alloc] initWithFrom:from
                                                                     to:to];
        [expectedMoves addObject:move];
    }

    NSArray<NTESListDiffMove *> *sortedMoves = sorted(result.moves);
    XCTAssertEqualObjects(result.deletes, expectedDeletes);
    XCTAssertEqualObjects(result.inserts, expectedInserts);
    XCTAssertEqualObjects(sortedMoves, expectedMoves);
}

@end
