DECLARE @Content NVARCHAR(MAX) 

------------------------------Question-----------------------------------------

SET @content = 'comment selectionner une question ?'

IF NOT EXISTS (SELECT NULL FROM Question Where Content = @Content)
BEGIN 
  INSERT INTO Survey(Content) VALUES (@Content)
END

