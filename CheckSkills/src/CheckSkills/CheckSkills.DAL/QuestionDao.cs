using CheckSkills.Domain.Entities;
using CheckSkills.Domain;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

namespace CheckSkills.DAL
{
    public class QuestionDao : IQuestionDao
    {
        //chaine de connexion base de donnée
        private  string connectionString = @"Data Source=SGEW0481\FORMULAIRE;Initial Catalog=CheckSkills;Integrated Security=true";

        public string Name { get; private set;} 

        public IEnumerable<Question> GetAll()
        {

            // Use ADO.Net to DB access
            var questions = new List<Question>();

            try
            {   
                //objet de connection 
                using (var connection = new SqlConnection(connectionString))
                {
                    // Do work here
                    connection.Open();
                    //objet permettant de faire des requêtes SQL
                    var scriptGetAllQuestion = @"
                                                SELECT 
	                                                q.Id,
	                                                q.CategoryId,
	                                                q.DifficultyId,
	                                                q.QuestionTypeId,
	                                                q.Content,
	                                                c.Name AS CategoryName,
	                                                d.DifficultyLevel ,
	                                                qt.Name AS QuestionTypeName
                                                FROM Question q
                                                INNER JOIN Difficulty d ON q.DifficultyId = d.Id
                                                INNER JOIN QuestionType qt ON q.QuestionTypeId = qt.Id
                                                INNER JOIN Category c ON q.CategoryId = c.Id";

                    var sqlCommand = new SqlCommand(scriptGetAllQuestion, connection);
                    //recupère les données dans la resultReader
                    var resultReader = sqlCommand.ExecuteReader(); //lecture et stockage du resultat dans resultReader
                    //parse ResultReader 
                    while (resultReader.Read())
                    {
                        var question = new Question()
                        {
                            Id = Convert.ToInt32(resultReader["Id"]),//recupère l'id de question dans la database et le converti
                            Category = new Category()
                            {
                                Id = Convert.ToInt32(resultReader["CategoryId"]),
                                Name = resultReader["CategoryName"].ToString()
                            },
                            Content = resultReader["Content"].ToString(),

                            Difficulty = new Difficulty()
                            {
                                Id = Convert.ToInt32(resultReader["DifficultyId"]),
                                DifficultyLevel = resultReader["DifficultyLevel"].ToString()
                            },
                            QuestionType = new QuestionType()
                            {
                                Id = Convert.ToInt32(resultReader["QuestionTypeId"]),
                                Name = resultReader["QuestionTypeName"].ToString()
                            },

                        };
                        questions.Add(question);
                    }
                }

            }
            catch (Exception e)
            {
                Console.WriteLine("L'erreur suivante a été rencontrée :" + e.Message);
            }

            return questions;
        }


        //methode permettant d'insérer une question dans la base de donnée
        public int CreateQuestion(Question q)
        {
            using (SqlConnection sqlConnection1 = new SqlConnection(connectionString)) // using permet de refermer la connection après ouverture
            {
                SqlCommand cmd = new SqlCommand  // objet cmd me permet d'exécuter des requêtes SQL
                {
                    CommandType = CommandType.Text, // methode permettant de definir le type de commande (text = une commande sql; Storeprocedure= le nom de la procedure stockée; TableDirect= le nom d'une table.
                    CommandText = "INSERT Question (CategoryId, DifficultyId, QuestionTypeID,Content) VALUES (@CategoryId,@DifficultyId, @QuestionTypeID,@Content); SELECT SCOPE_IDENTITY();", // stock la requete sql dans commandText. SCOPE_IDENTITY renvoie la dernière ligne de la base de donnée.
                    Connection = sqlConnection1, // etablie la connection.
                };


                // permet de definir les variables values dans CommandText. 
                cmd.Parameters.AddWithValue("@CategoryId", q.Category.Id);
                cmd.Parameters.AddWithValue("@DifficultyId", q.Difficulty.Id);
                cmd.Parameters.AddWithValue("@QuestionTypeID", q.QuestionType.Id);
                cmd.Parameters.AddWithValue("@Content", q.Content);

                sqlConnection1.Open(); //ouvre la connection à la base de donnée.

                var result = cmd.ExecuteScalar(); // execute la requete et return l'element de la première ligne à la première colonne

                if (result != null && int.TryParse(result.ToString(),out var questionId)) // convertit result.ToString() en int et le stock dans questionId
                {
                    return questionId;
                }

                return 0;
            }


        }
    }
}
