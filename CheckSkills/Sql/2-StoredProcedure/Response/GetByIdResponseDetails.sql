USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetByIdResponseDetails')
DROP Procedure GetByIdResponseDetails
GO
Create procedure [dbo].GetByIdResponseDetails  
(
	@Id INT
)
as
begin  
   SELECT Id,QuestionId,Content FROM Response WHERE Id=@Id ;
End