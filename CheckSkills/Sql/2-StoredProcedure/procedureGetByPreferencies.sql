USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetByPreferencies')
DROP Procedure GetByPreferencies
GO
Create procedure [dbo].GetByPreferencies
@questionCategoryId int,
@questionDifficultyId int,
@questionTypeId int

as
begin  
   SELECT Id,QuestionCategoryId,QuestionDifficultyId,QuestionTypeId,Content FROM Question 
   where QuestionCategoryId = @questionCategoryId
   and QuestionDifficultyId = @questionDifficultyId
   and QuestionTypeId = @questionTypeId
    ;
End