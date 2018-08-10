USE  [CheckSkills]
Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewQuestion')
DROP PROCEDURE AddNewQuestion
GO
Create procedure [dbo].AddNewQuestion  
(
 @Id INT
)
AS
BEGIN 
  DELETE FROM Question Where Id = @Id;
END
