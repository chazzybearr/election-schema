drop schema if exists election cascade;
create schema election;
set search_path to election;

CREATE TABLE Campaigns (
	campaign_id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	spending_limit MONEY NOT NULL CHECK (spending_limit > 0::MONEY)
);

CREATE TABLE Moderators (
	moderator_id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE Debates (
	debate_id SERIAL PRIMARY KEY,
	start_time TIMESTAMP NOT NULL
	
);

CREATE TABLE Moderates (
	moderates_id SERIAL PRIMARY KEY,
	debate_id INTEGER NOT NULL,
	moderator_id INTEGER NOT NULL,
	FOREIGN KEY (debate_id) REFERENCES Debates (debate_id)
	ON DELETE CASCADE,
	FOREIGN KEY (moderator_id) REFERENCES Moderators (moderator_id)
	ON DELETE CASCADE
);

CREATE TABLE Candidates (
	email TEXT PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE CampaignCandidates (
	campaign_candidate_id SERIAL PRIMARY KEY,
	campaign_id INTEGER NOT NULL,
	candidate_email TEXT NOT NULL,
	FOREIGN KEY (campaign_id) REFERENCES Campaigns (campaign_id)
	ON DELETE CASCADE,
	FOREIGN KEY (candidate_email) REFERENCES Candidates (email)
	ON DELETE CASCADE
);

CREATE TABLE DebateCandidates (
	debate_candidate_id SERIAL PRIMARY KEY,
	debate_id INTEGER NOT NULL,
	candidate_email TEXT NOT NULL,
	FOREIGN KEY (debate_id) REFERENCES Debates (debate_id)
	ON DELETE CASCADE,
	FOREIGN KEY (candidate_email) REFERENCES Candidates (email)
	ON DELETE CASCADE
);


CREATE TABLE Workers (
	email TEXT PRIMARY KEY,
	name TEXT NOT NULL,
	is_staff BOOLEAN NOT NULL,
	UNIQUE (email)
);

CREATE TABLE Donor (
	email TEXT PRIMARY KEY,
	name TEXT NOT NULL,
	address TEXT NOT NULL,
	is_individual BOOLEAN NOT NULL
);

CREATE TABLE Donates (
	donation_id SERIAL PRIMARY KEY,
	amount MONEY NOT NULL CHECK (amount > 0::MONEY),
	donor_email TEXT NOT NULL,
	campaign INTEGER NOT NULL,
	FOREIGN KEY (donor_email) REFERENCES Donor (email)
	ON DELETE CASCADE,
	FOREIGN KEY (campaign) REFERENCES Campaigns (campaign_id)
	ON DELETE CASCADE
);


CREATE TABLE WorkBlock (
	work_block_id SERIAL PRIMARY KEY,
	start_time TIMESTAMP NOT NULL,
	end_time TIMESTAMP NOT NULL,
	is_phone_bank BOOLEAN NOT NULL,
	campaign_id INTEGER NOT NULL,
	FOREIGN KEY (campaign_id) REFERENCES Campaigns (campaign_id)
	ON DELETE CASCADE
);

CREATE TABLE Works (
	work_id SERIAL PRIMARY KEY,
	worker_email TEXT NOT NULL,
	work_block_id INTEGER NOT NULL,
	FOREIGN KEY (worker_email) REFERENCES Workers (email)
	ON DELETE CASCADE,
	FOREIGN KEY (work_block_id) REFERENCES WorkBlock (work_block_id)
	ON DELETE CASCADE
);



