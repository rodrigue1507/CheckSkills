DECLARE @Name NVARCHAR(200)
DECLARE @Content NVARCHAR(MAX)
DECLARE @SurveyEvaluation NVARCHAR(MAX) 
------------------------------Survey-----------------------------------------
SET @name = ''
set @content = ''
@SurveyEvaluation = ''

IF NOT EXISTS (SELECT NULL FROM Survey Where Name = @Name)
BEGIN 
  INSERT INTO Survey(Name,Content,SurveyEvaluation ) VALUES (@Name,@Content,@SurveyEvaluation)
END

