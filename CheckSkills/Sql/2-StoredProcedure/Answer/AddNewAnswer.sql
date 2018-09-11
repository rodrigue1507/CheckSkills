USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewAnswer')
DROP PROCEDURE AddNewAnswer

GO
Create procedure [dbo].AddNewAnswer
(
 @questionId INT,
 @content VARCHAR(50)
)

AS
BEGIN 
  INSERT INTO Answer(QuestionId,Content) VALUES(@questionId,@content);
END
