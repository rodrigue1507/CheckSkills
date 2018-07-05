DECLARE @Name NVARCHAR(200)
DECLARE @Content NVARCHAR(MAX) 
------------------------------QuestionType-----------------------------------------
SET @name = ''
set @content = ''
IF NOT EXISTS (SELECT NULL FROM QuestionType Where Name = @Name)
BEGIN 
  INSERT INTO QuestionType(Name,Content) VALUES (@Name,@Content)
 END