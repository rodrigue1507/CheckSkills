USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='DeleteQuestionCategory')
DROP PROCEDURE DeleteQuestionCategory

GO
Create procedure [dbo].[DeleteQuestionCategory]  
(
 @Id INT
)

AS
BEGIN 
  DELETE FROM QuestionCategory WHERE Id = @Id;
END

