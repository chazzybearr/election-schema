SET search_path TO election;

-- 1. List total organizational donations and total individual donations for each campaign


REVOKE ALL ON Campaigns, Moderators, Debates, Moderates, Candidates, 
              CampaignCandidates, DebateCandidates, Workers, Donor, Donates,
              WorkBlock, Works FROM caileyan;

GRANT SELECT (campaign_id) ON Campaigns TO caileyan;
GRANT SELECT (email, is_individual) ON Donor TO caileyan;
GRANT SELECT (donor_email, amount, campaign) ON Donates TO caileyan;

BEGIN;

SELECT
    campaign_id,
    -- Summing individual donations
    SUM (CASE WHEN donor.is_individual THEN donates.amount::NUMERIC ELSE 0 END) 
    	AS total_individual_donations,
    -- Summing organizational donations
    SUM (CASE WHEN NOT donor.is_individual THEN donates.amount::NUMERIC ELSE 0 
 	END) AS total_organizational_donations
FROM Campaigns, Donates, Donor 
WHERE Donor.email = Donates.donor_email AND Donates.campaign = Campaigns.campaign_id
GROUP BY campaign_id;



ROLLBACK;

-- 2. Find those volunteers who offer to work on every campaign in the dataset

REVOKE ALL ON Campaigns, Moderators, Debates, Moderates, Candidates,
              CampaignCandidates, DebateCandidates, Workers, Donor, Donates,
              WorkBlock, Works FROM caileyan;   

GRANT SELECT (email, is_staff) ON Workers TO caileyan;
GRANT SELECT (campaign_id) ON Campaigns TO caileyan;
GRANT SELECT (worker_email, work_block_id) ON Works TO caileyan;
GRANT SELECT (work_block_id, campaign_id) ON WorkBlock TO caileyan;



BEGIN;

CREATE VIEW Volunteers AS
SELECT email
FROM Workers
WHERE is_staff = false;

CREATE VIEW CampaignIds AS
SELECT campaign_id
FROM Campaigns;


CREATE VIEW ShouldHave AS
SELECT email, campaign_id
FROM Volunteers, CampaignIds;

CREATE VIEW VolunteerWork AS
SELECT email, campaign_id
FROM Volunteers, Works, WorkBlock
WHERE worker_email = email AND Works.work_block_id = WorkBlock.work_block_id;

CREATE VIEW DidNot AS
SELECT *
FROM ShouldHave
EXCEPT
SELECT *
FROM VolunteerWork;

SELECT DISTINCT email
FROM (
    SELECT DISTINCT email
    FROM ShouldHave

    EXCEPT ALL 

    SELECT DISTINCT email
    FROM DidNot
) result;

ROLLBACK;

-- 3. Find candidates who are involved in every debate

REVOKE ALL ON Campaigns, Moderators, Debates, Moderates, Candidates,         
              CampaignCandidates, DebateCandidates, Workers, Donor, Donates,
	      WorkBlock, Works FROM caileyan;

GRANT SELECT (debate_id) ON Debates TO caileyan;
GRANT SELECT (email) ON Candidates TO caileyan;
GRANT SELECT (debate_id, candidate_email) ON DebateCandidates TO caileyan;

BEGIN;

CREATE VIEW DebateIds AS
SELECT debate_id
FROM Debates;

CREATE VIEW ShouldHave AS
SELECT debate_id, email
FROM Debates, Candidates;

CREATE VIEW ActualDebates AS
SELECT debate_id, candidate_email as email
FROM DebateCandidates;

CREATE VIEW DidNot AS
SELECT *
FROM ShouldHave
EXCEPT
SELECT *
FROM ActualDebates;

SELECT DISTINCT email
FROM (
    SELECT DISTINCT email
    FROM ShouldHave
	
    EXCEPT ALL

    SELECT DISTINCT email
    FROM DidNot
) result;

ROLLBACK;


