USE  [CheckSkills]
 Go
 IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='DeleteQuestionDifficulty')
DROP PROCEDURE DeleteQuestionDifficulty

Go
Create procedure [dbo].[DeleteQuestionDifficulty]  
(
 @Id INT
)

AS
BEGIN 
  DELETE FROM QuestionDifficulty WHERE Id=@Id;

END
