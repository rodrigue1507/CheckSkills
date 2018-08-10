 USE  [CheckSkills]
 GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='DeleteQuestionType')
DROP PROCEDURE DeleteQuestionType

GO
Create procedure [dbo].[DeleteQuestionType]  
(
 @Id   INT 
)

AS
BEGIN 
  DELETE FROM QuestionType WHERE Id=@Id ;
END
