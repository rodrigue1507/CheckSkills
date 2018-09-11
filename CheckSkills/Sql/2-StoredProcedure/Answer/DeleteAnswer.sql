USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='DeleteAnswer')
DROP Procedure DeleteAnswer
GO
Create procedure [dbo].DeleteAnswer  
(  
	@RId INT
)  
as
begin  
   DELETE FROM Answer WHERE Id = @RId;
End