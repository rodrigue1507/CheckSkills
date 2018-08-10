USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllQuestionsDetails')
DROP Procedure GetAllQuestionsDetails
GO
Create procedure [dbo].GetAllQuestionsDetails  

as
begin  
   SELECT Id,QuestionCategoryId,QuestionDifficultyId,QuestionTypeId,Content FROM Question ;
End