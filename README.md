# election-schema
An SQL schema which represents possible public records about an election.

## Assumptions and constraints 
### Unenforcable Constraints
1. We cannot enforce the constraint that the same candidate or moderator cannot be at two or more debates at the same time or date, as this would require a trigger. 

### Constraints not enforced
1. We did not enforce the constraint that there is no overlap between candidates, volunteers, and staff.\
a. This constraint is possible to enforce without triggers or assertions by adding another table, which keep track of all the emails of  candidates, volunteers and staff, and forces them to be unique. \
b. If there is an overlap, the unique constraint will fail.

### Extra constraints
1. Each donation must be greater than 0 dollars.
2. The spending limit must also be greater than 0 dollars.

### Assumptions
1. Donors can donate to the same, or multiple campaigns more than once.
2. Debates do not have an end time, as you cannot tell how long a debate will last beforehand.
3. A debate may have more than one moderator.
4. A work block has a set start and end time, and corresponds to a specific campaign.
