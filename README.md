**TDD Connect Four**

When creating the array the first row is at the top.

When creating the board the first row is at the bottom.

**let(:)**

Board, Array - Helper Objects

Value will be cached for the duration of the example

Will be created once per example, and if it’s called multiple times within the same example, it will return the same instance

**let!(:)**

Summary
Use let when you want lazy evaluation and the variable should only be initialized when it is first called.
Use let! when you need the variable to be instantiated before each example, regardless of whether it’s referenced in that example.

**subject(:)**

describe Game, describe Check - Primary Objects

Used to represent the main object being tested in the context of the describe block

**Key Differences

Purpose: Use let for variables and helper methods; use subject to define the primary object under test.
Usage: You can have multiple let statements in a describe block, while there is usually one subject that describes what the block is testing.
When to Use Which?
Use let when you need to set up helper variables or objects that are not the main subject of the test.
Use subject when you want to clearly define what the main object of your test is, especially if it makes your tests more readable.
