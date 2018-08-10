USE[CheckSkills]
GO
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
					ADD QuestionCategoryId INT;
				END
			ELSE 
				BEGIN
					ALTER TABLE Question
					ALTER COLUMN QuestionCategoryId INT;
				END

			IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionDifficultyId' AND Object_ID = Object_ID( 'Question'))
				BEGIN
					ALTER TABLE Question
					ADD QuestionDifficultyId INT;
				END
			ELSE 
				BEGIN
					ALTER TABLE Question
					ALTER COLUMN QuestionDifficultyId INT;
				END


			IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'QuestionTypeId' AND Object_ID = Object_ID( 'Question'))
				BEGIN
					ALTER TABLE Question
					ADD QuestionTypeId INT;
				END
			ELSE 
				BEGIN
					ALTER TABLE Question
					ALTER COLUMN QuestionTypeId INT;
				END
		END
	