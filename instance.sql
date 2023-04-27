INSERT INTO Campaigns
VALUES (1, 'campaign1', 100),
       (2, 'campaign2', 200);

INSERT INTO Workers
VALUES ('bob@mail.com', 'bob', false),
       ('jim@mail.com', 'jim', false),
       ('joe@mail.com', 'joe', true);

INSERT INTO WorkBlock
VALUES (1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, true, 1),
       (2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, true, 2);

INSERT INTO Works
VALUES (DEFAULT, 'bob@mail.com', 1),
       (DEFAULT, 'bob@mail.com', 2),
       (DEFAULT, 'jim@mail.com', 1),
       (DEFAULT, 'joe@mail.com', 1),
       (DEFAULT, 'joe@mail.com', 2);

INSERT INTO Candidates
VALUES ('danny@mail.com', 'danny'),
       ('mario@mail.com', 'mario');

INSERT INTO Debates
VALUES (1, CURRENT_TIMESTAMP),
       (2, CURRENT_TIMESTAMP);

INSERT INTO DebateCandidates
VALUES (DEFAULT, 1, 'danny@mail.com'),
       (DEFAULT, 2, 'danny@mail.com'),
       (DEFAULT, 1, 'mario@mail.com');

INSERT INTO Donor
VALUES ('donor@mail.com', 'donor', '123 St George', true),
       ('apple@mail.com', 'apple', '456 St George', false);

INSERT INTO Donates
VALUES (DEFAULT, 100, 'donor@mail.com', 1),
       (DEFAULT, 100, 'donor@mail.com', 1),
       (DEFAULT, 100, 'apple@mail.com', 1),
       (DEFAULT, 100, 'apple@mail.com', 2);
