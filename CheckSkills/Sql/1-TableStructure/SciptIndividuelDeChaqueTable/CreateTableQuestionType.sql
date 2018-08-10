USE[CheckSkills]
GO
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
	