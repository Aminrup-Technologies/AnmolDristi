using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AnmolDristi.DAL
{
    public class QCInspectorDataAccess
    {
        private readonly string connectionString;

        public QCInspectorDataAccess()
        {
            // Get the connection string from the configuration file
            connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        }

        public void InsertQCInspectorData(string plantName, string line, string productCategory, string productBrand,
                                      int numberOfPieces, decimal gaugeValue, decimal dryWeight, decimal dippedWeight,
                                      string varietyOrLotNo, string bakingTime, int flavourAndTaste, string commentsForFlavourAndTaste,
                                      decimal textureBite, int shapeOrSize, string commentsForShapeOrSize, decimal moisture,
                                      decimal gaugeLength, decimal weightWithoutOil, decimal weightWithOil, decimal oilPercentage,
                                      decimal packetWeight, string designAndImplementation, string colourAndAppearance,
                                      int submittedById, DateTime submittedDate, TimeSpan submittedTime, string SubmittedByPNo)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertQCInspectorData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@PlantName", plantName);
                    command.Parameters.AddWithValue("@Line", line);
                    command.Parameters.AddWithValue("@ProductCategory", productCategory);
                    command.Parameters.AddWithValue("@ProductBrand", productBrand);
                    command.Parameters.AddWithValue("@NumberOfPieces", numberOfPieces);
                    command.Parameters.AddWithValue("@GaugeValue", gaugeValue);
                    command.Parameters.AddWithValue("@DryWeight", dryWeight);
                    command.Parameters.AddWithValue("@DippedWeight", dippedWeight);
                    command.Parameters.AddWithValue("@VarietyOrLotNo", varietyOrLotNo);
                    command.Parameters.AddWithValue("@BakingTime", bakingTime);
                    command.Parameters.AddWithValue("@FlavourAndTaste", flavourAndTaste);
                    command.Parameters.AddWithValue("@CommentsForFlavourAndTaste", commentsForFlavourAndTaste);
                    command.Parameters.AddWithValue("@TextureBite", textureBite);
                    command.Parameters.AddWithValue("@ShapeOrSize", shapeOrSize);
                    command.Parameters.AddWithValue("@CommentsForShapeOrSize", commentsForShapeOrSize);
                    command.Parameters.AddWithValue("@Moisture", moisture);
                    command.Parameters.AddWithValue("@GaugeLength", gaugeLength);
                    command.Parameters.AddWithValue("@WeightWithoutOil", weightWithoutOil);
                    command.Parameters.AddWithValue("@WeightWithOil", weightWithOil);
                    command.Parameters.AddWithValue("@OilPercentage", oilPercentage);
                    command.Parameters.AddWithValue("@PacketWeight", packetWeight);
                    command.Parameters.AddWithValue("@DesignAndImplementation", designAndImplementation);
                    command.Parameters.AddWithValue("@ColourAndAppearance", colourAndAppearance);
                    command.Parameters.AddWithValue("@SubmittedById", submittedById);
                    command.Parameters.AddWithValue("@SubmittedDate", submittedDate);
                    command.Parameters.AddWithValue("@SubmittedTime", submittedTime);
                    command.Parameters.AddWithValue("@SubmittedByPNo", SubmittedByPNo);

                    // Open the connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}