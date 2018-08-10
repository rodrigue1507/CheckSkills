USE[CheckSkills]
GO
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
	