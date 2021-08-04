* Econ Seminar *

* import file *
import excel "/Users/mduran2429/Desktop/baseball_cube_data/Stata/stata_spreadsheet_hitters.xlsx", sheet("Stata Spreadsheet") firstrow

generate log_bonus = log(Bonus)


scatter log_bonus milb_rc
scatter log_bonus milb_OPS
scatter log_bonus overall
scatter log_bonus milb_RBI
scatter log_bonus milb_AVG

cor Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed milb_SO MLB_SO Age milb_rc MLB_rc

*****************************************************
* Starting with Moneyball Model, i.e. only statistics *

* model 1
reg log_bonus milb_OPS, robust
ereturn list r2_a
test milb_OPS

* model 2
reg log_bonus milb_OPS milb_rc, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc

* model 3
reg log_bonus milb_OPS milb_rc Age, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc
test milb_OPS milb_rc Age

* model 4
reg log_bonus milb_OPS milb_rc Age MLB_OPS, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc
test milb_OPS milb_rc Age
test milb_OPS milb_rc Age MLB_OPS

* model 5
reg log_bonus milb_OPS milb_rc Age MLB_OPS MLB_rc, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc
test milb_OPS milb_rc Age
test milb_OPS milb_rc Age MLB_OPS
test milb_OPS milb_rc Age MLB_OPS MLB_rc


* model 7
reg log_bonus milb_OPS milb_rc Age MLB_OPS MLB_rc overall, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc
test milb_OPS milb_rc Age
test milb_OPS milb_rc Age MLB_OPS
test milb_OPS milb_rc Age MLB_OPS MLB_rc
test milb_OPS milb_rc Age MLB_OPS MLB_rc overall
predict moneyball
generate moneyball_residual = log_bonus - moneyball


* model 6, not including in table *
reg log_bonus milb_OPS milb_rc Age made_bigs, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc
test milb_OPS milb_rc Age
test milb_OPS milb_rc Age made_bigs

* model 8, not using
reg log_bonus milb_OPS milb_rc Age milb_Gamesplayed made_bigs overall, robust
ereturn list r2_a
test milb_OPS
test milb_OPS milb_rc
test milb_OPS milb_rc Age
test milb_OPS milb_rc Age milb_Gamesplayed
test milb_OPS milb_rc Age milb_Gamesplayed made_bigs
test milb_OPS milb_rc Age milb_Gamesplayed made_bigs overall

*model 9, not using
reg log_bonus milb_OPS milb_rc Age milb_RBI, robust

**************************************************************************************
* Scouts Model Qualitative, i.e. only qualitative variables *

* model 1 *
reg log_bonus Heightinches,robust
ereturn list r2_a
test Heightinches

* model 2 *
reg log_bonus Heightinches Weightlbs,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs

* model 3 *
reg log_bonus Heightinches Weightlbs Age,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs
test Heightinches Weightlbs Age

* model 4 *
xi: reg log_bonus Heightinches Weightlbs Age i.Location,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs
test Heightinches Weightlbs Age
testparm _ILocation_*

* model 5 *
xi: reg log_bonus Heightinches Weightlbs Age i.Location i.Position,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs
test Heightinches Weightlbs Age
testparm _ILocation_*
testparm _IPosition_*
predict scouts
generate scouts_residual = log_bonus - scouts

**************************************************************************************
*Astroball Model combination*

* Model 1 *
reg log_bonus milb_OPS Heightinches, robust
ereturn list r2_a
test milb_OPS
test milb_OPS Heightinches

* Model 2 *
reg log_bonus milb_OPS Heightinches MLB_OPS, robust
ereturn list r2_a
test milb_OPS
test milb_OPS Heightinches
test milb_OPS Heightinches MLB_OPS

* Model 3*
reg log_bonus milb_OPS Heightinches MLB_OPS Age, robust
ereturn list r2_a
test milb_OPS
test milb_OPS Heightinches
test milb_OPS Heightinches MLB_OPS
test milb_OPS Heightinches MLB_OPS Age

* Model 4*
reg log_bonus milb_OPS Heightinches MLB_OPS Age overall, robust
ereturn list r2_a
test milb_OPS
test milb_OPS Heightinches
test milb_OPS Heightinches MLB_OPS
test milb_OPS Heightinches MLB_OPS Age
test milb_OPS Heightinches MLB_OPS Age overall

* Model 5*
xi: reg log_bonus milb_OPS Heightinches MLB_OPS Age overall i.Location, robust
ereturn list r2_a
test milb_OPS
test milb_OPS Heightinches
test milb_OPS Heightinches MLB_OPS
test milb_OPS Heightinches MLB_OPS Age
test milb_OPS Heightinches MLB_OPS Age overall
testparm _ILocation_*

* Model 5*
xi: reg log_bonus milb_OPS Heightinches MLB_OPS Age overall i.Location i.Position, robust
ereturn list r2_a
test milb_OPS
test milb_OPS Heightinches
test milb_OPS Heightinches MLB_OPS
test milb_OPS Heightinches MLB_OPS Age
test milb_OPS Heightinches MLB_OPS Age overall
testparm _ILocation_*
testparm _IPosition_*
predict astroball
generate astroball_residual = log_bonus - astroball

*****************************************************
*Pitchers stuff*

import excel "/Users/mduran2429/Desktop/baseball_cube_data/Stata/stata_spreadsheet_pitchers.xlsx", sheet("Sheet1") firstrow

generate log_bonus = log(Bonus)

* Starting with Moneyball Model, i.e. only statistics *

* model 1
reg log_bonus milb_so9, robust
ereturn list r2_a
test milb_so9

* model 2
reg log_bonus milb_so9 milb_bb9, robust
ereturn list r2_a
test milb_so9
test milb_so9 milb_bb9

* model 3
reg log_bonus milb_so9 milb_bb9 Age, robust
ereturn list r2_a
test milb_so9
test milb_so9 milb_bb9
test milb_so9 milb_bb9 Age

* model 4
reg log_bonus milb_so9 milb_bb9 Age MLB_so9, robust
ereturn list r2_a
test milb_so9
test milb_so9 milb_bb9
test milb_so9 milb_bb9 Age
test milb_so9 milb_bb9 Age MLB_so9

* model 5
reg log_bonus milb_so9 milb_bb9 Age MLB_so9 MLB_bb9, robust
ereturn list r2_a
test milb_so9
test milb_so9 milb_bb9
test milb_so9 milb_bb9 Age
test milb_so9 milb_bb9 Age MLB_so9
test milb_so9 milb_bb9 Age MLB_so9 MLB_bb9


* model 7
reg log_bonus milb_so9 milb_bb9 Age MLB_so9 MLB_bb9 overall, robust
ereturn list r2_a
test milb_so9
test milb_so9 milb_bb9
test milb_so9 milb_bb9 Age
test milb_so9 milb_bb9 Age MLB_so9
test milb_so9 milb_bb9 Age MLB_so9 MLB_bb9
test milb_so9 milb_bb9 Age MLB_so9 MLB_bb9 overall
predict moneyball
generate moneyball_residual = log_bonus - moneyball


**************************************************************************************
* Scouts Model Qualitative, i.e. only qualitative variables *

* model 1 *
reg log_bonus Heightinches,robust
ereturn list r2_a
test Heightinches

* model 2 *
reg log_bonus Heightinches Weightlbs,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs

* model 3 *
reg log_bonus Heightinches Weightlbs Age,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs
test Heightinches Weightlbs Age

* model 4 *
xi: reg log_bonus Heightinches Weightlbs Age i.Location,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs
test Heightinches Weightlbs Age
testparm _ILocation_*
predict scouts
generate scouts_residual = log_bonus - scouts

* model 5 *
xi: reg log_bonus Heightinches Weightlbs Age i.Location,robust
ereturn list r2_a
test Heightinches
test Heightinches Weightlbs
test Heightinches Weightlbs Age
testparm _ILocation_*


**************************************************************************************
*Astroball Model combination*

* Model 1 *
reg log_bonus milb_so9 Heightinches, robust
ereturn list r2_a
test milb_so9
test milb_so9 Heightinches

* Model 2 *
reg log_bonus milb_so9 Heightinches MLB_so9, robust
ereturn list r2_a
test milb_so9
test milb_so9 Heightinches
test milb_so9 Heightinches MLB_so9

* Model 3*
reg log_bonus milb_so9 Heightinches MLB_so9 Age, robust
ereturn list r2_a
test milb_so9
test milb_so9 Heightinches
test milb_so9 Heightinches MLB_so9
test milb_so9 Heightinches MLB_so9 Age

* Model 4*
reg log_bonus milb_so9 Heightinches MLB_so9 Age overall, robust
ereturn list r2_a
test milb_so9
test milb_so9 Heightinches
test milb_so9 Heightinches MLB_so9
test milb_so9 Heightinches MLB_so9 Age
test milb_so9 Heightinches MLB_so9 Age overall

* Model 5*
xi: reg log_bonus milb_so9 Heightinches MLB_so9 Age overall i.Location, robust
ereturn list r2_a
test milb_so9
test milb_so9 Heightinches
test milb_so9 Heightinches MLB_so9
test milb_so9 Heightinches MLB_so9 Age
test milb_so9 Heightinches MLB_so9 Age overall
testparm _ILocation_*
predict astroball
generate astroball_residual = log_bonus - astroball

**************************************
*last analysis - test hypothesis*
*need to reshape the data*
*DSSC SLIDES https://drive.google.com/drive/u/1/folders/0Bx505nNmlUojTVBaWW1ncWpvUVU     *

import excel "/Users/mduran2429/Desktop/baseball_cube_data/Stata/win percentages.xlsx", sheet("Sheet1") cellrange(A1:AD31) firstrow

* to get the the panel data, panel-variable is team, time variable is year *
reshape long win payroll, i(Team) j(Year)
encode Team, generate(Team_id)
xtset Team_id Year
scatter win payroll
generate log_payroll = log(payroll)
scatter win log_payroll


xtreg win log_payroll, robust
test log_payroll

xtreg win hitter_hit_rate, robust
test hitter_hit_rate

xtreg win pitcher_hit_rate, robust
test pitcher_hit_rate

xtreg win log_payroll hitter_hit_rate, robust
test hitter_hit_rate
test hitter_hit_rate log_payroll
test log_payroll

xtreg win log_payroll hitter_hit_rate pitcher_hit_rate, robust
test hitter_hit_rate
test log_payroll
test pitcher_hit_rate
test hitter_hit_rate log_payroll
test hitter_hit_rate log_payroll pitcher_hit_rate

. import excel "/Users/mduran2429/Desktop/Columbia University/Spring '19/Sports Economics/baseball_cube_data/Stata/win percentages copy 2.xlsx", sheet("Sheet1") cell range(A1:AI31) firstrow

xtreg win HS_hitter_hit_rate
test HS_hitter_hit_rate

xtreg win college_hitter_hit_rate
test college_hitter_hit_rate

xtreg win HS_pitcher_hit_rate
test HS_pitcher_hit_rate

xtreg win college_pitcher_hit_rate
test college_pitcher_hit_rate

xtreg win international_players_hit_rate
test international_players_hit_rate

******************************************


* Remove strikeouts since highly correlated with MLB Games and MILB GAMES *

cor Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age

*correlations seem low so run*

reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age

*need to encode group*

encode Group, generate(Draft_group)

cor Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age Draft_group

reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Group

reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed i.international

* reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed i.international i.Location

replace MLB_Gamesplayed=0 if MLB_Gamesplayed==.

cor Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age international overall

reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age international overall

reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age i.international overall

* Checking to see if predict works

replace MLB_OPS=0 if MLB_OPS==.

reg Bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Age i.international overall

predict Bonus_tilde

gen residuals=(Bonus-Bonus_tilde)


* Just checking to see how log bonus works *

generate log_bonus = log(Bonus)
reg log_bonus Heightinches milb_OPS MLB_OPS milb_Gamesplayed MLB_Gamesplayed Draft_group, r


* May want to add in some other variables that will help explain bonuses***********
