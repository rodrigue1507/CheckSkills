USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='UpdateAnswerDetails')
DROP PROCEDURE UpdateAnswerDetails
GO
Create procedure [dbo].UpdateAnswerDetails  
(  
	@RId INT,
	@QuestionId INT,
	@Content Varchar(50)
)  
as
begin  
   Update Answer
   set QuestionId=@QuestionId,
   Content=@Content
   where Id=@Rid;  
End