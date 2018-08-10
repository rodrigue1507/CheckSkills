using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace CheckSkills.DAL
{
    public class ResponseDao : IResponseDao
    {
        //chaine de connexion base de donnée
        private string _connectionString = @"Data Source=SGEW0481\FORMULAIRE;Initial Catalog=CheckSkills;Integrated Security=true";

        public string Name { get; private set; }

        public IEnumerable<Response> GetAll()
        {

            // Use ADO.Net to DB access
            var Responses = new List<Response>();

            try
            {
                //objet de connection 
                using (var connection = new SqlConnection(_connectionString))
                {
                    // Do work here
                    connection.Open();
                    //objet permettant de faire des requêtes SQL
                    var scriptGetAllResponse = @"
                                                SELECT 
	                                                r.Id,
	                                                r.Content,
                                                    r.QuestionId
                                                    FROM Response r
                                                            ";

                    var sqlCommand = new SqlCommand(scriptGetAllResponse, connection);
                    //recupère les données dans la resultReader
                    var resultReader = sqlCommand.ExecuteReader(); //lecture et stockage du resultat dans resultReader
                    //parse ResultReader 
                    while (resultReader.Read())
                    {
                        var Response = new Response()
                        {
                            Id = Convert.ToInt32(resultReader["Id"]),//recupère l'id de Category dans la database et le converti
                            Content = resultReader["Content"].ToString(),
                            QuestionId = Convert.ToInt32(resultReader["QuestionId"])

                        };
                        Responses.Add(Response);
                    }
                }

            }
            catch (Exception e)
            {
                Console.WriteLine("L'erreur suivante a été rencontrée :" + e.Message);
            }

            return Responses;
        }
        public int CreateResponse(Response r)
        {
            using (SqlConnection sqlConnection1 = new SqlConnection(_connectionString)) // using permet de refermer la connection après ouverture
            {
                SqlCommand cmd = new SqlCommand  // objet cmd me permet d'exécuter des requêtes SQL
                {
                    CommandType = CommandType.Text, // methode permettant de definir le type de commande (text = une commande sql; Storeprocedure= le nom de la procedure stockée; TableDirect= le nom d'une table.
                    CommandText = "INSERT INTO Response (Content,QuestionId) VALUES (@Content,@QuestionId); SELECT SCOPE_IDENTITY();", // stock la requete sql dans commandText. SCOPE_IDENTITY renvoie l'Id de  la question inseré.
                    Connection = sqlConnection1, // etablie la connection.
                };


                // permet de definir les variables values dans CommandText. 
                cmd.Parameters.AddWithValue("@Content", r.Content);
                cmd.Parameters.AddWithValue("@QuestionId", r.QuestionId);
                sqlConnection1.Open(); //ouvre la connection à la base de donnée.

                var result = cmd.ExecuteScalar(); // execute la requete et return l'element de la première ligne à la première colonne

                if (result != null && int.TryParse(result.ToString(), out var questionId)) // convertit result.ToString() en int et le stock dans questionId
                {
                    return questionId;
                }

                return 0;
            }


        }
        public void DeleteResponse(int reponseId)
        {
            using (SqlConnection sqlConnection1 = new SqlConnection(_connectionString)) // using permet de refermer la connection après ouverture
            {
                SqlCommand cmd = new SqlCommand  // objet cmd me permet d'exécuter des requêtes SQL
                {
                    CommandType = CommandType.Text, // methode permettant de definir le type de commande (text = une commande sql; Storeprocedure= le nom de la procedure stockée; TableDirect= le nom d'une table.
                    CommandText = "DELETE FROM Response WHERE Id = @ResponseId", // stock la requete sql dans commandText.
                    Connection = sqlConnection1, // etablie la connection.
                };
                // permet de definir les variables values dans CommandText.
                cmd.Parameters.AddWithValue("@ResponseId", reponseId);

                sqlConnection1.Open(); //ouvre la connection à la base de donnée.

                cmd.ExecuteNonQuery();
            }
        }

        public int UpdateResponse(Response r)
        {
            using (SqlConnection sqlConnection1 = new SqlConnection(_connectionString)) // using permet de refermer la connection après ouverture
            {
                SqlCommand cmd = new SqlCommand  // objet cmd me permet d'exécuter des requêtes SQL
                {
                    CommandType = CommandType.Text, // methode permettant de definir le type de commande (text = une commande sql; Storeprocedure= le nom de la procedure stockée; TableDirect= le nom d'une table.
                    CommandText = "UPDATE Response SET Content = @Content  WHERE Id = @responseId", 
                    Connection = sqlConnection1, // etablie la connection.
                };


                // permet de definir les variables values dans CommandText.
                cmd.Parameters.AddWithValue("@responseId", r.Id);
                cmd.Parameters.AddWithValue("@Content", r.Content);

                sqlConnection1.Open(); //ouvre la connection à la base de donnée.

                var result = cmd.ExecuteNonQuery(); // execute et retoune la premier ligne
                if (result > 0 && int.TryParse(result.ToString(), out var questionId))
                {
                    return questionId;
                }

                return 0;
            }
        }
    }
}
