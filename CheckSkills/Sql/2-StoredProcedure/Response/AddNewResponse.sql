USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewResponse')
DROP PROCEDURE AddNewResponse

GO
Create procedure [dbo].AddNewResponse  
(
 @questionId INT,
 @content VARCHAR(50)
)

AS
BEGIN 
  INSERT INTO Response(QuestionId,Content) VALUES(@questionId,@content);
END
