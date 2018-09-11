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
-------------------------------------------CREATION QuestionDifficulty------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='QuestionDifficulty')
	BEGIN 
		CREATE TABLE QuestionDifficulty (
			Id INT PRIMARY KEY IDENTITY,
			QuestionDifficultyLevel TINYINT
		);
	END

-------------------------------------------CREATION QuestionType------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='QuestionType')
	BEGIN 
		CREATE TABLE QuestionType (
			Id INT  PRIMARY KEY IDENTITY,
			Name VARCHAR(200)
		);
	END


-------------------------------------------CREATION Question------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Question')
	BEGIN 
		CREATE TABLE Question(
			Id INT PRIMARY KEY IDENTITY,
			QuestionCategoryId INT  FOREIGN KEY REFERENCES QuestionCategory(Id),
			QuestionDifficultyId INT  FOREIGN KEY REFERENCES QuestionDifficulty(Id),
			QuestionTypeId INT  FOREIGN KEY REFERENCES QuestionType(Id),
			Content VARCHAR(MAX),
			QuestionEvaluation VARCHAR(MAX)
		);
	END 
-------------------------------------------CREATION Response------------------------------------------------
IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Answer')
	BEGIN 
		CREATE TABLE Answer(
			Id INT PRIMARY KEY IDENTITY,
			QuestionId INT  FOREIGN KEY REFERENCES Question(Id),
			Content VARCHAR(MAX),
			IsTrue Bit
		);
	END

-------------------------------------------CREATION Survey------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey')
	BEGIN
	CREATE TABLE Survey (
		Id INT PRIMARY KEY IDENTITY,
		Name VARCHAR(200),
		Content VARCHAR(MAX),
		SurveyEvaluation VARCHAR(MAX)
	);
	END

-------------------------------------------CREATION Survey_Question------------------------------------------------

IF NOT EXISTS(SELECT NULL FROM sys.tables WHERE name='Survey_Question')
	BEGIN
		CREATE TABLE Survey_Question (
			Id INT PRIMARY KEY IDENTITY,
			QuestionId INT  FOREIGN KEY REFERENCES Question(Id),
			SurveyId INT  FOREIGN KEY REFERENCES Survey(Id),
		);
	END
END