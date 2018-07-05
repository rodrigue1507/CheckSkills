DECLARE @Name NVARCHAR(200)
DECLARE @Content NVARCHAR(MAX) 
------------------------------Survey-----------------------------------------
SET @name = ''
set @content = ''
IF NOT EXISTS (SELECT NULL FROM Survey Where Name = @Name)
BEGIN 
  INSERT INTO Survey(Name,Content) VALUES (@Name,@Content)
END

