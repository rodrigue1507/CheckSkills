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
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'QuestionCategory'))
	BEGIN	
		ALTER TABLE QuestionCategory
		ADD  Name VARCHAR(200)
	END

-------------------------------------------CREATION QuestionDifficulty------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='QuestionDifficulty')
	BEGIN 
		CREATE TABLE QuestionDifficulty (
			Id INT PRIMARY KEY IDENTITY,
			QuestionDifficultyLevel TINYINT
		);
	END
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'QuestionDifficultyLevel' AND Object_ID = Object_ID( 'QuestionDifficulty'))
			BEGIN	
				ALTER TABLE QuestionDifficulty
				ADD  QuestionDifficultyLevel TINYINT;
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
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'QuestionType'))
	BEGIN	
		ALTER TABLE QuestionType
		ADD  Name VARCHAR(200);
	END

-------------------------------------------CREATION Question------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Question')
	BEGIN 
		CREATE TABLE Question(
			Id INT PRIMARY KEY IDENTITY,
			QuestionCategoryId INT ,
			QuestionDifficultyId INT ,
			QuestionTypeId INT ,
			Content VARCHAR(MAX)
		);
	END 

IF NOT EXISTS(SELECT NULL FROM sys.foreign_keys where name= 'FK_QuestionCategoryId_QuestionId')
	BEGIN 
	   ALTER TABLE Question 
	   ADD CONSTRAINT FK_QuestionCategoryId_QuestionId
	   FOREIGN KEY  (QuestionCategoryId) REFERENCES  QuestionCategory(Id);
	END

IF NOT EXISTS(SELECT NULL FROM sys.foreign_keys where name= 'FK_QuestionTypeId_QuestionId')
	BEGIN 
	   ALTER TABLE Question 
	   ADD CONSTRAINT FK_QuestionTypeId_QuestionId
	   FOREIGN KEY  (QuestionTypeId) REFERENCES  QuestionType(Id);
	END
IF NOT EXISTS(SELECT NULL FROM sys.foreign_keys where name= 'FK_QuestionDifficultyId_QuestionId')
	BEGIN 
	   ALTER TABLE Question 
	   ADD CONSTRAINT FK_QuestionDifficultyId_QuestionId
	   FOREIGN KEY  (QuestionDifficultyId) REFERENCES  QuestionDifficulty(Id);
	END
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID('Question'))
	BEGIN	
		ALTER TABLE Question
		ADD  Content VARCHAR(200);
	END
-------------------------------------------CREATION Response------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Response')
	BEGIN 
		CREATE TABLE Response(
			Id INT PRIMARY KEY IDENTITY,
			QuestionId INT ,
			Content VARCHAR(MAX),
			IsCorrect BIT
		);
	END
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID( 'Response'))
	BEGIN	
		ALTER TABLE Response
		ADD  Content VARCHAR(200);
	END

IF NOT EXISTS (SELECT NULL FROM sys.foreign_keys WHERE  name= 'FK_ResponseId_QuestionId' )
	BEGIN
			ALTER TABLE Response
			ADD CONSTRAINT FK_ResponseId_QuestionId 
			FOREIGN KEY (QuestionId) REFERENCES Question(Id);
	END

IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'ISCorrect' AND Object_ID = Object_ID('Response'))
	BEGIN
		ALTER TABLE Response
		ADD  IsCorrect BIT;
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
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Name' AND Object_ID = Object_ID( 'Survey'))
	BEGIN	
		ALTER TABLE Survey
		ADD  Name VARCHAR(200);
	END

IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Content' AND Object_ID = Object_ID( 'Survey'))
	BEGIN
		ALTER TABLE Survey
		ADD Content VARCHAR(MAX);
	END

IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'SurveyEvaluation1')
	BEGIN
		ALTER TABLE Survey
		ADD  SurveyEvaluation1 VARCHAR(MAX);
	END
		
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'SurveyEvaluation2' AND Object_ID = Object_ID( 'Survey'))
	BEGIN
		ALTER TABLE Survey
		ADD  SurveyEvaluation2 VARCHAR(MAX);
	END


-------------------------------------------CREATION Survey_Question------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey_Question')
	BEGIN
		CREATE TABLE Survey_Question (
			Id INT PRIMARY KEY IDENTITY,
			QuestionId INT,
			SurveyId INT ,
			Survey_QuestionEvaluation1 VARCHAR(MAX),
			Survey_QuestionEvaluation2 VARCHAR(MAX)
		);
END
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE Name='FK_Survey_QuestionId_QuestionId')
	BEGIN
			ALTER TABLE Survey_Question
			ADD CONSTRAINT FK_Survey_QuestionId_QuestionId
			FOREIGN KEY (QuestionId) REFERENCES Question(Id);
	END
IF NOT EXISTS (SELECT 1 FROM  sys.foreign_keys WHERE Name = 'FK_Survey_QuestionId_SurveyId')
	BEGIN
		ALTER TABLE Survey_Question
		ADD CONSTRAINT FK_Survey_QuestionId_SurveyId
		FOREIGN KEY(SurveyId) REFERENCES Survey(Id);
	END

IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Survey_QuestionEvaluation1' AND Object_ID = Object_ID( 'Survey'))
	BEGIN
		ALTER TABLE Survey
		ADD  Survey_QuestionEvaluation1 VARCHAR(MAX);
	END
		
IF NOT EXISTS (SELECT NULL FROM sys.columns WHERE Name = 'Survey_QuestionEvaluation2' AND Object_ID = Object_ID( 'Survey'))
	BEGIN
		ALTER TABLE Survey
		ADD  Survey_QuestionEvaluation2 VARCHAR(MAX);
	END
