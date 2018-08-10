USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetByIdQuestionDetails')
DROP Procedure GetByIdQuestionDetails
GO
Create procedure [dbo].GetByIdQuestionDetails  
(
	@Id INT
)
as
begin  
   SELECT Id,QuestionCategoryId,QuestionDifficultyId,QuestionTypeId,Content FROM Question WHERE Id=	@Id;
End