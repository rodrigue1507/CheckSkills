USE[CheckSkills]
GO
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey_Question')
BEGIN
CREATE TABLE Survey_Question (
	Id INT PRIMARY KEY IDENTITY,
	QuestionId INT FOREIGN KEY REFERENCES Question(Id),
	SurveyId INT FOREIGN KEY REFERENCES Survey(Id),
	QuestionEvaluation1 VARCHAR(MAX),
	QuestionEvaluation2 VARCHAR(MAX)
);
END
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey_Question')
	BEGIN
	CREATE TABLE Survey (
		Id INT PRIMARY KEY IDENTITY,
		Name VARCHAR(200),
		Content VARCHAR(MAX),
		SurveyEvaluation1 VARCHAR(MAX),
		SurveyEvaluation2 VARCHAR(MAX)
	);
	END

ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN	
				ALTER TABLE Survey_Question
				ADD  Name VARCHAR(200);
			END
		ELSE
			BEGIN
				ALTER TABLE Survey_Question
				ALTER  COLUMN Name VARCHAR(200);
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN
				ALTER TABLE Survey_Question
				ADD Content VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey_Question
				ALTER COLUMN Content VARCHAR(MAX);
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'SurveyEvaluation1' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN
				ALTER TABLE Survey_Question
				ADD  SurveyEvaluation1 VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey_Question
				ALTER COLUMN SurveyEvaluation1 VARCHAR(MAX);
			END
		
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'SurveyEvaluation2' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN
				ALTER TABLE Survey_Question
				ADD  SurveyEvaluation2 VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey_Question
				ALTER COLUMN SurveyEvaluation2 VARCHAR(MAX);
			END
	END
