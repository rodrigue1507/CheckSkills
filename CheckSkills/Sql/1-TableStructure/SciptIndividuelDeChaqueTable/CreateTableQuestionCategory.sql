USE[CheckSkills]
GO
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
					ADD  Name VARCHAR(200);
				END

			ELSE
				BEGIN
					ALTER TABLE QuestionCategory
					ALTER  COLUMN Name VARCHAR(200);
				END

		END
	