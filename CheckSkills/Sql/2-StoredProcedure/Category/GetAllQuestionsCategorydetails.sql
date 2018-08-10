USE  [CheckSkills]
Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllQuestionsCategoryDetails')
DROP PROCEDURE GetAllQuestionsCategoryDetails
Go
Create Procedure [dbo].[GetAllQuestionsCategoryDetails]  
as  
begin  
   select Id, Name from QuestionCategory
End