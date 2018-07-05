Create procedure [dbo].[AddNewCategory]  
--)
-- @Name varchar (50),
-- @Content (50)
--)
as
BEGIN 
  INSERT INTO Category VALUES (@Name,@Content)
END
