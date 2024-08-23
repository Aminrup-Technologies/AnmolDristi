using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;

namespace AnmolDristi.DAL
{
    public class QAProcessCheckingDataAcess
    {
        private readonly string connectionString;

        public QAProcessCheckingDataAcess()
        {
            // Get the connection string from the configuration file
            connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        }

        public void InsertBasicData(string plantName, string line, string productCategory, string productBrand, DateTime date, char shift, TimeSpan time,
                                    decimal processWaterTemp, decimal waterPh, decimal waterHardness, decimal waterTest, decimal tds,
                                    string maidaBrand, int maidaBatchNo, int maidaMfg, int maidaAppColor, string commentForMaidaAppColor,
                                    int maidaFlavorTaste, string commentForMaidaFlavorTaste, int maidaGrittiness, string commentsForMaidaGrittiness,
                                    int bbAppColor, string commentForBBColor, int bbMouthFeel, string commentForBBMouthFeel, int bbFlavorTaste, string commentForBBFlavorTaste,
                                    int hvoSmell, string commentForHvoSmell, int hvoTaste, string commentForHvoTaste, decimal hvoTemp, int smpSmell, string commentForSmpSmell,
                                    int smpTaste, string commentForSmpTaste, int smpColor, string commentForSmpColor, decimal syrupTemp, int syrupColor, string commentForSyrupColor,
                                    decimal syrupPh, int invertSyrup, string commentForInvertSyrup, int sugarSol, string commentForSugarSol, int creamerBucket, string commentForCreamerBucket,
                                    int sugarGrinder, string commentForSugarGrinder, int oilSystem, string commentForOilSystem, int oilSpray, string commentForOilSpray, int milkSpray,
                                    string commentForMilkSpray, decimal coldRoomTemp, decimal DeepFreezeTemp)

        {
            using (SqlConnection connection = new SqlConnection(connectionString)) 
            {
                using (SqlCommand command = new SqlCommand("InsertBasicData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@PlantName", plantName);
                    command.Parameters.AddWithValue("@Line", line);
                    command.Parameters.AddWithValue("@ProductCategory", productCategory);
                    command.Parameters.AddWithValue("@ProductBrand", productBrand);
                    command.Parameters.AddWithValue("@Date", date);
                    command.Parameters.AddWithValue("@Shift",shift);
                    command.Parameters.AddWithValue("@Time",time);
                    command.Parameters.AddWithValue("@ProcessWaterTemp",processWaterTemp);
                    command.Parameters.AddWithValue("@WaterPH", waterPh);
                    command.Parameters.AddWithValue("@WaterHardness",waterHardness);
                    command.Parameters.AddWithValue("@WaterTest",waterTest);
                    command.Parameters.AddWithValue("@TDS", tds);
                    command.Parameters.AddWithValue("@MaidaBrand", maidaBrand);
                    command.Parameters.AddWithValue("@MaidaBatchNo", maidaBatchNo);
                    command.Parameters.AddWithValue("@MaidaMfgDate", maidaMfg);
                    command.Parameters.AddWithValue("@MaidaAppearanceColor", maidaAppColor);
                    command.Parameters.AddWithValue("@CommentForMaidaColor", commentForMaidaAppColor);
                    command.Parameters.AddWithValue("@MaidaFlavorAndTaste", maidaFlavorTaste );
                    command.Parameters.AddWithValue("@CommentsForMaidaFlavourAndTaste", commentForMaidaFlavorTaste);
                    command.Parameters.AddWithValue("@MaidaGrittiness", maidaGrittiness);
                    command.Parameters.AddWithValue("@CommentForGrittiness",commentsForMaidaGrittiness );
                    command.Parameters.AddWithValue("@BBAppearanceColor",bbAppColor );
                    command.Parameters.AddWithValue("@CommentForBBColor", commentForBBColor);
                    command.Parameters.AddWithValue("@BBMouthFeel", bbMouthFeel);
                    command.Parameters.AddWithValue("@CommentForBBMouthFeel", commentForBBMouthFeel);
                    command.Parameters.AddWithValue("@BBFlavorAndTaste", bbFlavorTaste);
                    command.Parameters.AddWithValue("@CommentForBBFlavorAndTaste", commentForBBFlavorTaste);
                    command.Parameters.AddWithValue("@BBAppearanceColor", bbAppColor);
                    command.Parameters.AddWithValue("@HvoSmell", hvoSmell);
                    command.Parameters.AddWithValue("@CommentForHvoSmell", commentForHvoSmell);
                    command.Parameters.AddWithValue("@HvoTaste",hvoTaste);
                    command.Parameters.AddWithValue("@CommentForHvoTaste",commentForHvoTaste);
                    command.Parameters.AddWithValue("@HvoTemp",hvoTemp);
                    command.Parameters.AddWithValue("@SmpSmell",smpSmell);
                    command.Parameters.AddWithValue("@CommentForSmpSmell",commentForSmpSmell);
                    command.Parameters.AddWithValue("@SmpTaste",smpTaste);
                    command.Parameters.AddWithValue("@CommentForSmpTaste",commentForSmpTaste);
                    command.Parameters.AddWithValue("@SmpColor",smpColor);
                    command.Parameters.AddWithValue("@CommentForSmpColor",commentForSmpColor);
                    command.Parameters.AddWithValue("@SyrupTemp",syrupTemp);
                    command.Parameters.AddWithValue("@SyrupColor",syrupColor);
                    command.Parameters.AddWithValue("@CommentForSyrupColor",commentForSyrupColor);
                    command.Parameters.AddWithValue("@SyrupPH",syrupPh);
                    command.Parameters.AddWithValue("@InvertSyrpBucketFilter",invertSyrup);
                    command.Parameters.AddWithValue("@CommentForISBF",commentForInvertSyrup);
                    command.Parameters.AddWithValue("@SugarSolBucketFilter",sugarSol);
                    command.Parameters.AddWithValue("@CommentForSSBF",commentForSugarSol);
                    command.Parameters.AddWithValue("@CreamerBucketFilter",creamerBucket);
                    command.Parameters.AddWithValue("@CommentForCBF",commentForCreamerBucket);
                    command.Parameters.AddWithValue("@SugarGrindedSheet",sugarGrinder);
                    command.Parameters.AddWithValue("@CommentForSGS",commentForSugarGrinder);
                    command.Parameters.AddWithValue("@OilSystemBucketFilter",oilSystem);
                    command.Parameters.AddWithValue("@CommentForOSBF",commentForOilSystem);
                    command.Parameters.AddWithValue("@OilSpray",oilSpray);
                    command.Parameters.AddWithValue("@CommentForOilSpray",commentForOilSpray);
                    command.Parameters.AddWithValue("@MilkSpray",milkSpray);
                    command.Parameters.AddWithValue("@CommentForMilkSpray",commentForMilkSpray);
                    command.Parameters.AddWithValue("@ColdRoomTemp",coldRoomTemp);
                    command.Parameters.AddWithValue("@DeepFreezeTemp",DeepFreezeTemp);


                    // Open the connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }


            }
        }


        public void InsertRawMaterialData(string plantName1, string maidaBrandName, decimal maidaWgt, decimal sugarWgt, decimal butter, decimal smp, 
                                    decimal processWater, decimal lecithin, decimal gms, decimal ssl, decimal glucose, decimal hvo, decimal syrup, 
                                    decimal malt, decimal bb, decimal abc, decimal sbc, decimal smbs, decimal wheyPowder, decimal condenceMilk, decimal salt,
                                    decimal yeast, decimal e1, decimal caramel)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertRawMaterialData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@PlantName", plantName1);
                    command.Parameters.AddWithValue("@MaidaBrandName", maidaBrandName);
                    command.Parameters.AddWithValue("@MaidaActWgt", maidaWgt);
                    command.Parameters.AddWithValue("@SugarActWgt", sugarWgt);
                    command.Parameters.AddWithValue("@ButterActWgt", butter);
                    command.Parameters.AddWithValue("@SmpActWgt", smp);
                    command.Parameters.AddWithValue("@ProcessWaterActualWgt", processWater);
                    command.Parameters.AddWithValue("@LecithinActWgt", lecithin);
                    command.Parameters.AddWithValue("@GmsActWgt", gms);
                    command.Parameters.AddWithValue("@PasteOrPowderActWgt", ssl);
                    command.Parameters.AddWithValue("@GlucoseActWgt", glucose);
                    command.Parameters.AddWithValue("@HvoActWgt", hvo);
                    command.Parameters.AddWithValue("@SyrupActWgt", syrup);
                    command.Parameters.AddWithValue("@MaltActWgt", malt);
                    command.Parameters.AddWithValue("@BBActWgt", bb);
                    command.Parameters.AddWithValue("@AbcActWgt", abc);
                    command.Parameters.AddWithValue("@SbcActWgt", sbc);
                    command.Parameters.AddWithValue("@SmbsActWgt", smbs);
                    command.Parameters.AddWithValue("@WheyPowderActWgt", wheyPowder);
                    command.Parameters.AddWithValue("@MilkActWgt", condenceMilk);
                    command.Parameters.AddWithValue("@SaltActWgt", salt);
                    command.Parameters.AddWithValue("@YeastActWgt", yeast);
                    command.Parameters.AddWithValue("@E1ActWgt", e1);
                    command.Parameters.AddWithValue("@CaramelActWgt", caramel);
                    


                    // Open the connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }

            }
        }


        public void InsertSpongeData(string plantName2, decimal roomTemp, int drumCovered, string commentForDrumCovered, int quality, string commentForQuality,
                                string standingTime, decimal temp)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertSpongeData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@PlantName", plantName2);
                    command.Parameters.AddWithValue("@RoomTemp", roomTemp);
                    command.Parameters.AddWithValue("@DrumCovered", drumCovered);
                    command.Parameters.AddWithValue("@DrumCmnt", commentForDrumCovered);
                    command.Parameters.AddWithValue("@Quality", quality);
                    command.Parameters.AddWithValue("@QualityCmnt", commentForQuality);
                    command.Parameters.AddWithValue("@StandingTime", standingTime);
                    command.Parameters.AddWithValue("@Temp", temp);


                    // Open the connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }

            }
        }


        public void InsertDoughData(string plantName3, decimal doughTemp, string restTime, int metalDetector, string commentForMetalDetector, int processSequence,
                                string commentForProcessSequence, string creamingTime, string mixingTime, string bakingTime, int diceRmp, int doughCondition,
                                string commentForDoughCondition)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertDoughData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@PlantName", plantName3);
                    command.Parameters.AddWithValue("@DoughTemp", doughTemp);
                    command.Parameters.AddWithValue("@DoughRestTime", restTime);
                    command.Parameters.AddWithValue("@MetalDetector", metalDetector);
                    command.Parameters.AddWithValue("@DetectorCmnt", commentForMetalDetector);
                    command.Parameters.AddWithValue("@ProcessSequence",processSequence );
                    command.Parameters.AddWithValue("@SequenceCmnt", commentForProcessSequence);
                    command.Parameters.AddWithValue("@CreamingTime",creamingTime);
                    command.Parameters.AddWithValue("@MixingTime",mixingTime);
                    command.Parameters.AddWithValue("@BakingTime",bakingTime);
                    command.Parameters.AddWithValue("@DiceRpm",diceRmp);
                    command.Parameters.AddWithValue("@DoughCondition",doughCondition);
                    command.Parameters.AddWithValue("@DoughCmnt",commentForDoughCondition);


                    // Open the connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }

            }
        }

        public void InsertOvenData(string plantName4, string zone1Top ,string zone1Bottom ,string zone2Top ,string zone2Bottom ,string zone3Top , string zone3Bottom ,
                              string zone4Top , string zone4Bottom ,string zone5Top ,string zone5Bottom , string zone6Top ,string zone6Bottom ,
                              string DPzone1Top , string DPzone1Bottom ,string DPzone2Top ,string DPzone2Bottom ,string DPzone3Top ,string DPzone3Bottom ,
                              string DPzone4Top ,string DPzone4Bottom , string DPzone5Top ,string DPzone5Bottom , string DPzone6Top ,string DPzone6Bottom ) 
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertOvenData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@PlantName", plantName4);
                    command.Parameters.AddWithValue("@OvenZone1Top",zone1Top);
                    command.Parameters.AddWithValue("@OvenZone1Bottom",zone1Bottom);
                    command.Parameters.AddWithValue("@OvenZone2Top",zone2Top);
                    command.Parameters.AddWithValue("@OvenZone2Bottom", zone2Bottom);
                    command.Parameters.AddWithValue("@OvenZone3Top",zone3Top);
                    command.Parameters.AddWithValue("@OvenZone3Bottom", zone3Bottom);
                    command.Parameters.AddWithValue("@OvenZone4Top",zone4Top);
                    command.Parameters.AddWithValue("@OvenZone4Bottom", zone4Bottom);
                    command.Parameters.AddWithValue("@OvenZone5Top", zone5Top);
                    command.Parameters.AddWithValue("@OvenZone5Bottom",zone5Bottom);
                    command.Parameters.AddWithValue("@OvenZone6Top",zone6Top);
                    command.Parameters.AddWithValue("@OvenZone6Bottom", zone6Bottom);

                    command.Parameters.AddWithValue("@DamperZone1Top",DPzone1Top);
                    command.Parameters.AddWithValue("@DamperZone1Bottom",DPzone1Bottom);
                    command.Parameters.AddWithValue("@DamperZone2Top",DPzone2Top);
                    command.Parameters.AddWithValue("@DamperZone2Bottom",DPzone2Bottom);
                    command.Parameters.AddWithValue("@DamperZone3Top",DPzone3Top);
                    command.Parameters.AddWithValue("@DamperZone3Bottom",DPzone3Bottom);
                    command.Parameters.AddWithValue("@DamperZone4Top",DPzone4Top);
                    command.Parameters.AddWithValue("@DamperZone4Bottom",DPzone4Bottom);
                    command.Parameters.AddWithValue("@DamperZone5Top",DPzone5Top);
                    command.Parameters.AddWithValue("@DamperZone5Bottom",DPzone5Bottom);
                    command.Parameters.AddWithValue("@DamperZone6Top",DPzone6Top);
                    command.Parameters.AddWithValue("@DamperZone6Bottom",DPzone6Bottom);


                    // Open the connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }

            }
        }


        public void InsertVerifiedData(int balanceCond , string commentForBalanceCond , string rawBiscuitWgt ,
                                        int submittedById, DateTime submittedDate, TimeSpan submittedTime, string SubmittedByPNo)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertVerifiedData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@WghBalanceCond", balanceCond);
                    command.Parameters.AddWithValue("@WghBalanceCmnt", commentForBalanceCond);
                    command.Parameters.AddWithValue("@RawBiscuitWgt", rawBiscuitWgt);
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