DECLARE @Content NVARCHAR(MAX) 

------------------------------Response-----------------------------------------
SET @content = ''
IF NOT EXISTS (SELECT NULL FROM Survey Where  @Content = @Content)
BEGIN 
  INSERT INTO Survey(Content) VALUES (@Content)
END


