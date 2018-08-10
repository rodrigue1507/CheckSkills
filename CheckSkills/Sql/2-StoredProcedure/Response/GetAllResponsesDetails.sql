USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllResponsesDetails')
DROP Procedure GetAllResponsesDetails
GO
Create procedure [dbo].GetAllResponsesDetails  

as
begin  
   SELECT Id,QuestionId,Content FROM Response;
End