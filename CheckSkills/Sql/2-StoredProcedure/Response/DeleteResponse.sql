USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='DeleteResponse')
DROP Procedure DeleteResponse
GO
Create procedure [dbo].DeleteResponse  
(  
	@RId INT
)  
as
begin  
   DELETE FROM Response WHERE Id = @RId;
End