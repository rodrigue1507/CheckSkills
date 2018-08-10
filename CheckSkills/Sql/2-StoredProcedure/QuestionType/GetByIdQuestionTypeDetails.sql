USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetByIdQuestionTypeDetails')
DROP PROCEDURE GetByIdQuestionTypeDetails
GO
Create procedure [dbo].[GetByIdQuestionTypeDetails]  
(
	@Id INT
)
AS
BEGIN 
  Select Id,Name FROM QuestionType WHERE Id=@Id;
END
