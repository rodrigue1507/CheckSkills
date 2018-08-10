USE[CheckSkills]
GO
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
					ADD QuestionId INT;
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
	