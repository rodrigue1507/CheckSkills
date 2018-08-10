Use[CheckSkills]
Go

BEGIN

-------------------------------------------CREATION QuestionCategory------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='QuestionCategory')
	BEGIN 
		CREATE TABLE QuestionCategory (
			Id INT  PRIMARY KEY IDENTITY,
			Name VARCHAR(200)
		);
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'QuestionCategory'))
			BEGIN	
				ALTER TABLE QuestionCategory
				ADD  Name VARCHAR(200)
			END

		ELSE
			BEGIN
				ALTER TABLE QuestionCategory
				ALTER  COLUMN Name VARCHAR(200);
			END

	END

-------------------------------------------CREATION QuestionDifficulty------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='QuestionDifficulty')
	BEGIN 
		CREATE TABLE QuestionDifficulty (
			Id INT PRIMARY KEY IDENTITY,
			QuestionDifficultyLevel TINYINT
		);
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionDifficultyLevel' AND Object_ID = Object_ID( 'QuestionDifficulty'))
			BEGIN	
				ALTER TABLE QuestionDifficulty
				ADD  QuestionDifficultyLevel TINYINT;
			END

		ELSE
			BEGIN
				ALTER TABLE QuestionDifficulty
				ALTER  COLUMN QuestionDifficultyLevel TINYINT;
			END

	END
	
-------------------------------------------CREATION QuestionType------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='QuestionType')
	BEGIN 
		CREATE TABLE QuestionType (
			Id INT  PRIMARY KEY IDENTITY,
			Name VARCHAR(200)
		);
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'QuestionType'))
			BEGIN	
				ALTER TABLE QuestionType
				ADD  Name VARCHAR(200);
			END

		ELSE
			BEGIN
				ALTER TABLE QuestionType
				ALTER  COLUMN Name VARCHAR(200);
			END

	END
	
-------------------------------------------CREATION Question------------------------------------------------
	
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Question')
	BEGIN 
		CREATE TABLE Question(
			Id INT PRIMARY KEY IDENTITY,
			QuestionCategoryId INT FOREIGN KEY REFERENCES QuestionCategory(Id),
			QuestionDifficultyId INT FOREIGN KEY REFERENCES QuestionDifficulty(Id),
			QuestionTypeId INT FOREIGN KEY REFERENCES QuestionType(Id),
			Content VARCHAR(MAX)
		);
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID( 'Question'))
			BEGIN	
				ALTER TABLE Question
				ADD  Content VARCHAR(200);
			END
		ELSE
			BEGIN
				ALTER TABLE Question
				ALTER  COLUMN Content VARCHAR(200);
			END


		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionCategoryId' AND Object_ID = Object_ID( 'Question'))
			BEGIN
				ALTER TABLE Question
				ADD QuestionCategoryId INT
				IF NOT EXISTS (SELECT * FROM sys. ) 
					BEGIN
						 ALTER TABLE Question 
						 ADD FOREIGN KEY (QuestionCategoryId) REFERENCES QuestionCategory(Id);
					END
			END
		ELSE 
			BEGIN
				ALTER TABLE Question
				ALTER COLUMN QuestionCategoryId INT;
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionDifficultyId' AND Object_ID = Object_ID('Question'))
			BEGIN
				ALTER TABLE Question
				ADD QuestionDifficultyId INT
				IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Question_QuestionDifficultyId') AND parent_object_id = OBJECT_ID(N'dbo.Question'))
					BEGIN
						 ALTER TABLE Question 
						 ADD FOREIGN KEY (QuestionDifficultyId) REFERENCES QuestionDifficulty(Id);
					END
			END
		ELSE 
			BEGIN
				ALTER TABLE Question
				ALTER COLUMN QuestionDifficultyId INT;
			END


		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionTypeId' AND Object_ID = Object_ID( 'Question'))
			BEGIN
				ALTER TABLE Question
				ADD QuestionTypeId INT
				IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Question_QuestionTypeId') AND parent_object_id = OBJECT_ID(N'dbo.Question'))
					BEGIN
						 ALTER TABLE Question 
						 ADD FOREIGN KEY (QuestionTypeId) REFERENCES QuestionType(Id);
					END
			END
		ELSE 
			BEGIN
				ALTER TABLE Question
				ALTER COLUMN QuestionTypeId INT;
			END
	END
	
-------------------------------------------CREATION Response------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Response')
		BEGIN 
			CREATE TABLE Response(
				Id INT PRIMARY KEY IDENTITY,
				QuestionId INT FOREIGN KEY REFERENCES Question(Id),
				Content VARCHAR(MAX),
				IsCorrect BIT
			);
		END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID( 'Response'))
			BEGIN	
				ALTER TABLE Response
				ADD  Content VARCHAR(200);
			END
		ELSE
			BEGIN
				ALTER TABLE Response
				ALTER  COLUMN Content VARCHAR(200);
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionId' AND Object_ID = Object_ID( 'Response'))
			BEGIN
				ALTER TABLE Response
				ADD QuestionId INT
				IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Response_QuestionId') AND parent_object_id = OBJECT_ID(N'dbo.Response'))
					BEGIN
						 ALTER TABLE Response 
						 ADD FOREIGN KEY (QuestionId) REFERENCES Question(Id);
					END
			END
		ELSE 
			BEGIN
				ALTER TABLE Response
				ALTER COLUMN QuestionId INT;
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'ISCorrect' AND Object_ID = Object_ID( 'Response'))
			BEGIN
				ALTER TABLE Response
				ADD  IsCorrect BIT;
			END
		ELSE 
			BEGIN
				ALTER TABLE Response
				ALTER COLUMN IsCorrect BIT;
			END

	END
	
-------------------------------------------CREATION Survey------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey')
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
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'Survey'))
			BEGIN	
				ALTER TABLE Survey
				ADD  Name VARCHAR(200);
			END
		ELSE
			BEGIN
				ALTER TABLE Survey
				ALTER  COLUMN Name VARCHAR(200);
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID( 'Survey'))
			BEGIN
				ALTER TABLE Survey
				ADD Content VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey
				ALTER COLUMN Content VARCHAR(MAX);
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'SurveyEvaluation1' AND Object_ID = Object_ID( 'Survey'))
			BEGIN
				ALTER TABLE Survey
				ADD  SurveyEvaluation1 VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey
				ALTER COLUMN SurveyEvaluation1 VARCHAR(MAX);
			END
		
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'SurveyEvaluation2' AND Object_ID = Object_ID( 'Survey'))
			BEGIN
				ALTER TABLE Survey
				ADD  SurveyEvaluation2 VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey
				ALTER COLUMN SurveyEvaluation2 VARCHAR(MAX);
			END
	END

-------------------------------------------CREATION Survey_Question------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey_Question')
	BEGIN
		CREATE TABLE Survey_Question (
			Id INT PRIMARY KEY IDENTITY,
			QuestionId INT FOREIGN KEY REFERENCES Question(Id),
			SurveyId INT FOREIGN KEY REFERENCES Survey(Id),
			Survey_QuestionEvaluation1 VARCHAR(MAX),
			Survey_QuestionEvaluation2 VARCHAR(MAX)
		);
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Survey_Question_QuestionId') AND parent_object_id = OBJECT_ID(N'dbo.Survey_Question'))
			BEGIN
					ALTER TABLE Survey_Question 
					ADD FOREIGN KEY (QuestionId) REFERENCES Question(Id);
			END
		ELSE
			BEGIN
				ALTER TABLE Survey_Question
				ALTER  COLUMN QuestionId INT;
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'SurveyId' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN
				ALTER TABLE Survey_Question
				ADD SurveyId INT;
				IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Survey_Question_SurveyId') AND parent_object_id = OBJECT_ID(N'dbo.Survey_Question'))
					BEGIN
						 ALTER TABLE Survey_Question 
						 ADD FOREIGN KEY (SurveyId) REFERENCES Survey(Id);
					END
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey_Question
				ALTER COLUMN SurveyId INT;
			END

		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Survey_QuestionEvaluation1' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN
				ALTER TABLE Survey_Question
				ADD  Survey_QuestionEvaluation1 VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey_Question
				ALTER COLUMN Survey_QuestionEvaluation1 VARCHAR(MAX);
			END
		
		IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Survey_QuestionEvaluation2' AND Object_ID = Object_ID( 'Survey_Question'))
			BEGIN
				ALTER TABLE Survey_Question
				ADD  Survey_QuestionEvaluation2 VARCHAR(MAX);
			END
		ELSE 
			BEGIN
				ALTER TABLE Survey_Question
				ALTER COLUMN Survey_QuestionEvaluation2 VARCHAR(MAX);
			END
		END

END