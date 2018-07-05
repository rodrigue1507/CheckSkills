DECLARE @Content NVARCHAR(MAX) 
DECLARE @IsCorrect NVARCHAR(200)
------------------------------Response-----------------------------------------
SET @content = 'la reponse est correct'
set @Iscorrect = '1'
IF NOT EXISTS (SELECT NULL FROM Survey Where Iscorrect = @Iscorrect)
BEGIN 
  INSERT INTO Survey(Content,IsCorrect) VALUES (Content,Iscorrect)
END


