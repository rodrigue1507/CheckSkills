USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllQuestionDetails')
DROP Procedure GetAllQuestionDetails
GO
Create procedure [dbo].GetAllQuestionDetails  

as
begin  
   SELECT Id,QuestionCategoryId,QuestionDifficultyId,QuestionTypeId,Content FROM Question ;
End