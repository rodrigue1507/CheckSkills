DECLARE @Name NVARCHAR(200)

------------------------------Category-----------------------------------------

SET @Name = 'ASP Dotnet'

IF NOT EXISTS (SELECT NULL FROM QuestionCategory Where Name = @Name)
BEGIN 
  INSERT INTO QuestionCategory(Name) VALUES (@Name)
END



 


