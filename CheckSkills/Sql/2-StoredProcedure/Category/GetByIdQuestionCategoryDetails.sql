USE  [CheckSkills]
 Go
IF EXISTS(SELECT name FROM sys.objects WHERE type= 'P' AND name='GetByIdQuestionCategoryDetails')
 DROP PROCEDURE GetByIdQuestionCategoryDetails

GO

CREATE PROCEDURE [dbo].[GetByIdQuestionCategoryDetails] 
 
(  
	@qctgId int 
)  
AS 
 BEGIN
  select Id, Name From QuestionCategory  where Id=@qctgId  
END



