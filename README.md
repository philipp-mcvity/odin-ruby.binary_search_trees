### The Odin Project
#### Ruby
[##### Project: Binary Search Trees](https://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms)

_Since I misinterpreted one thing at first, originally_
```ruby
Tree.new
```
_did create a **BST**, but **not a balanced** one.
That will take the first element of the **unsorted** array which is passed to the method and lines up every following element up, one by one.
I eventually decided to keep it that way, this is practice, and since calling_
```ruby
Tree.new.rebalance!
```
_is designed to fix that anyway, like that there are both options._
