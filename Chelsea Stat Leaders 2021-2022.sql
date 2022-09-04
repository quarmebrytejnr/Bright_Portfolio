
-----Chelsea Stat Leaders-----------
SELECT *
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'

-----Players over 30-----------
SELECT *
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND AGE > 29

--------Players under 26-------------
SELECT *
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND AGE <26


-----Chelsea Stat Leaders-----------
SELECT Player, Pos, Age, MP Matches_Played,Starts, Min
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'




-----------Playmaking Stats--------------
------------Higest Passes Attempted-------
SELECT Player, Pos, Age, MP Matches_Played, Starts, Min, PasTotAtt Attempted_Passes_Per_90, PasTotCmp Completed_Passes_Per_90, [PasTotCmp%] Percentage_Completed_Passes_Per_90
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  ORDER BY 7 DESC

------------Highest Passes Completed-------
SELECT Player, Pos, Age, MP Matches_Played, Starts, Min, PasTotAtt Attempted_Passes_Per_90, PasTotCmp Completed_Passes_Per_90, [PasTotCmp%] Percentage_Completed_Passes_Per_90
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY 9 DESC

------------Passing Distance-------
------------Short Passes Acuraccy---------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min, PasShoAtt Attempted_Short_Passes, 	
  PasShoCmp Completed_Short_Passes, [PasShoCmp%] Per_Completed_Short_Passes
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY 9 DESC;

-----------Long Passes Accuarcy----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  PasLonAtt Attempted_Long_Passes, 	
  PasLonCmp Completed_Long_Passes, [PasLonCmp%] Per_Completed_Long_Passes
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY PasLonCmp DESC;

-----------Final 3rd Passes----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  PasShoAtt Attempted_Short_Passes, 	
  PasShoCmp Completed_Short_Passes,
  PasLonAtt Attempted_Long_Passes, 	
  PasLonCmp Completed_Long_Passes,
  Pas3rd Passes_To_Final_Third
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY Pas3rd DESC;

-----------Final 3rd Passes Assist Conversion----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  PasShoAtt Attempted_Short_Passes, 	
  PasShoCmp Completed_Short_Passes,
  PasLonAtt Attempted_Long_Passes, 	
  PasLonCmp Completed_Long_Passes,
  Pas3rd Passes_To_Final_Third,
  Assists
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY Assists DESC;

-----------Crosses to Assist Conversion----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  PasCrs Crosses_Completed,
  Assists
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY PasCrs DESC;

-----------Shot/Goal creating actions----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  SCA Shot_Creating_Actions,
  GCA Goal_Creating_Actions,
  Assists
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY SCA DESC;

-----------Pass Progression into Opponent Box----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,	
  PasShoCmp Completed_Short_Passes,
  PasLonCmp Completed_Long_Passes,
  Pas3rd Passes_To_Final_Third,
  PasProg Pass_Progression
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY PasProg DESC;

-----------Passes Not Completed----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,	
  PasShoCmp Completed_Short_Passes,
  PasLonCmp Completed_Long_Passes,
  PasOut Passes_Out_Of_Bounds,
  PasInt Passes_Intercepted
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY PasInt DESC;






-----Attacking Stats-----------

-----Best Attackers Coversion Rate------
-------Christian Pulisic had the best shot conversion with the second lowest shots leading to the Highest Goal Per Shot----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  Shots, SoT Shot_On_Target, [G/Sh] Goal_Per_Shot, 
  [G/SoT] Goal_Per_Shot_On_Target
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND Pos LIKE '%FW%'
  ORDER BY 10 DESC

----------Goals scored inside the BOX-------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min, 
  Goals Goals_Per_90, ShoDist Avg_Distance_from_Goal
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND Goals <> 0
  AND MP > 10
  AND ShoDist <= 18
  ORDER BY 8 

----------Goals scored outside the BOX-------------
SELECT
  Player, Pos, Age, MP Matches_Played, Starts, Min, 
  Goals Goals_Per_90, ShoDist Avg_Distance_from_Goal
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND Goals <> 0
  AND MP > 10
  AND ShoDist >= 18
  ORDER BY 8 DESC


-----Best Goal Scoring Players----------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min, 
  Goals Goals_Per_90
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND Goals <> 0
  AND MP > 10
  ORDER BY 7 DESC

-----------Touches in Final Third--------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,	
  Shots, SoT Shot_On_Target, [G/Sh] Goal_Per_Shot, 
  [G/SoT] Goal_Per_Shot_On_Target,
  Goals Goals_Per_90,
  TouAttPen Touches_In_Opponent_Box
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY TouAttPen DESC;

-----------Dribbles And Carries--------------
SELECT 
  Player, Pos,
  DriAtt Dribbles_attempted,
  DriSucc Dribbles_completed,
  Car3rd Carries_In_Opponent_Box,
  TouAttPen Touches_In_Opponent_Box,
  Goals Goals_Per_90
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY Dribbles_completed DESC;

  -----------Ball Retention Contributing to Attack--------------
SELECT 
  Player, Pos,
  PKwon Penalties_won,
  GcaFld Fouls_drawn_leading_to_a_goal,
  Car3rd Carries_In_Opponent_Box
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY 4 DESC;




-------------------Defenese Stats--------------------

-------------Tackles---------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  Tkl Tackles_Attempted,
  TklWon Tackles_Won,
  Recov Loose_balls_recovered
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY Tackles_Won DESC;
  


------------Dribbled Past-----------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  Tkl Tackles_Attempted,
  TklDriPast Dribbled_Past
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY Dribbled_Past DESC;


------------Press Impact-----------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  Press,
  PresSucc Press_Success,
  PresDef3rd Press_In_Def_Third,
  PresMid3rd Press_In_Midfield,
  PresAtt3rd Press_In_Att_Third
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY PresSucc DESC;


------------Defesive Errors-----------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  Fls Fouls_Committed,CrdY Yellow_Card, CrdR Red_Card, OG Own_Goal
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY Fls DESC;

----------Aerial Duels-------------
------------Defesive Errors-----------------
SELECT 
  Player, Pos, Age, MP Matches_Played, Starts, Min,
  AerWon Aerials_won,
  AerLost Aerials_lost,
  [AerWon%] Perc_of_aerials_won
  FROM [Portfolio_Project].[dbo].[Player_Data_Cleaned$]
  WHERE Squad = 'Chelsea'
  AND MP >10
  ORDER BY 7 DESC;