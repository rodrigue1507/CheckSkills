DECLARE @Name NVARCHAR(200)
DECLARE @Content NVARCHAR(MAX) 

DECLARE @IsCorrect BIT
------------------------------Category-----------------------------------------

SET @Name = 'SQL'
SET @Content = 'Question de type SQL'

IF NOT EXISTS (SELECT NULL FROM Category Where Name = @Name)
BEGIN 
  INSERT INTO Category(Name,Content) VALUES (@Name,@Content)
END

SET @Name = 'C#'
SET @Content = 'Question de type C#'

IF NOT EXISTS (SELECT NULL FROM Category Where Name = @Name)
BEGIN 
  INSERT INTO Category(Name,Content) VALUES (@Name,@Content)
END

SET @Name = 'Asp.Net-Asp.net MVC'
SET @Content = 'Question de type Asp.Net-Asp.net MVC'

IF NOT EXISTS (SELECT NULL FROM Category Where Name = @Name)
BEGIN 
  INSERT INTO Category(Name,Content) VALUES (@Name,@Content)
END

 


