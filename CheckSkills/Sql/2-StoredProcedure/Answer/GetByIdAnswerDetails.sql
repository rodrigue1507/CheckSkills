USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetByIdAnswerDetails')
DROP Procedure GetByIdAnswerDetails
GO
Create procedure [dbo].GetByIdAnswerDetails  
(
	@Id INT
)
as
begin  
   SELECT Id,QuestionId,Content FROM Answer WHERE Id=@Id ;
End