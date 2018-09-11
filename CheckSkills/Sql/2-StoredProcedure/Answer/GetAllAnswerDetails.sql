USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllAnswersDetails')
DROP Procedure GetAllAnswersDetails
GO
Create procedure [dbo].GetAllAnswersDetails  

as
begin  
   SELECT Id,QuestionId,Content FROM Answer;
End