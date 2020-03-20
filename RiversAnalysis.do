***** Replication data for Drought and the Militarization of International River Disputes
* George Williford
* Last updated: 20200317
* Packages required: eststo, sutex
cd "C:\Users\gwill\Dropbox\Research\ReplicationFiles\Drought-and-Conflict"
use RiversData.dta, clear


*****Primary Models
*** Model 1
eststo conchal: logit midissyr lagdev1 lograinyravg1 drctchal loglagtpop1 loglaggdpcap1 c.loglaggdpcap1#c.loglaggdpcap1 icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy, cluster(dyad)

*First differences and relative risk
su lagdev1
display r(mean)-r(sd)
display r(mean)+r(sd)
margins, at(lagdev1=(-1.1416748 .96560659))
display (0.0366757-.0122668)/0.0366757

*Drought duration graph
margins, at(drctchal=(1(1)10))
marginsplot, yline(0, lcolor(gray)) xline(1.547368, lcolor(gray) lpattern(dash)) ytitle("Probability of MID Initiation") recastci(rarea) plotopts(lwidth(medthick) lpattern(solid) msymbol(point) color(black)) title("") plotregion(margin(zero) lcolor(black)) graphregion(color(white)) ylab(,nogrid angle(verticle))
graph export "./tab/durchal.eps", replace


*** Model 2
eststo contgt:  logit midissyr lagdev2 lograinyravg2 drcttgt loglagtpop2 loglaggdpcap2 loglaggdpcap2sq icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy, cluster(dyad)
	
*First differences and relative risk
su lagdev2
display r(mean)-r(sd)
display r(mean)+r(sd)
margins, at(lagdev2=(-1.103678 1.0347782))
display (.0313499-.014868)/.0313499

*Drought duration graph
margins, at(drcttgt=(1(1)10))
marginsplot, yline(0, lcolor(gray)) xline(1.547368, lcolor(gray) lpattern(dash)) ytitle("Probability of MID Initiation") recastci(rarea) plotopts(lwidth(medthick) lpattern(solid) msymbol(point) color(black)) title("") plotregion(margin(zero) lcolor(black)) graphregion(color(white)) ylab(,nogrid angle(verticle))
graph export "./tab/durtgt.eps", replace


*** Model 3
eststo intchal: logit midissyr lagdev1 lograinyravg1 drctchal c.lagdev1#c.lograinyravg1 loglagtpop1 loglaggdpcap1 loglaggdpcap1sq icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy, cluster(dyad)
test lagdev1 c.lagdev1#c.lograinyravg1
margins, dydx(lagdev1) at(lograinyravg1=(5.72341 6.21462 6.6))


*** Model 4
eststo inttgt:  logit midissyr lagdev2 lograinyravg2 drcttgt c.lagdev2#c.lograinyravg2 loglagtpop2 loglaggdpcap2 loglaggdpcap2sq icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy, cluster(dyad)
test lagdev2 c.lagdev2#c.lograinyravg2
margins, dydx(lagdev2) at(lograinyravg2=(6.074798  6.578835 6.630877))


*****Tables
esttab conchal intchal using "./tab/chal.tex", replace label booktabs se nonotes varwidth(40) ///
starlevels(* 0.01)  collabels(,none) mlabels("(1)" "(2)", nodep notitles) nonumbers eqlabels(,none) ///
wrap varlabels(_cons Constant) stats(N ll, labels("Observations" "Log-likelihood") fmt(%9.0g)) ///
order(lagdev1 lograinyravg1 c.lagdev1#c.lograinyravg1 drctchal loglagtpop1 loglaggdpcap1 loglaggdpcap1sq icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy) gaps ///
refcat(lagdev1 "\textbf{\underline{Water Availability}}" loglagtpop1 "\textbf{\underline{Water Demands}}" icowsal "\textbf{\underline{River Controls}}" lagcincrat "\textbf{\underline{Dyadic Controls}}" , nolabel) ///
cells(b(star fmt(3)) se(par fmt(3)))

esttab contgt inttgt using "./tab/tgt.tex", replace label booktabs se nonotes varwidth(40) ///
starlevels(* 0.01)  collabels(,none) mlabels("(3)" "(4)", nodep notitles) nonumbers eqlabels(,none) /// 
wrap varlabels(_cons Constant) stats(N ll, labels("Observations" "Log-likelihood") fmt(%9.0g)) ///
order(lagdev2 lograinyravg2 c.lagdev2#c.lograinyravg2 drcttgt loglagtpop2 loglaggdpcap2 loglaggdpcap2sq icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy) gaps ///
refcat(lagdev2 "\textbf{\underline{Water Availability}}" loglagtpop2 "\textbf{\underline{Water Demands}}" icowsal "\textbf{\underline{River Controls}}" lagcincrat "\textbf{\underline{Dyadic Controls}}" , nolabel) ///
cells(b(star fmt(3)) se(par fmt(3)))
	
*****Summary Statistics
la var midissyr "MID Initiation"
la var lagdev1 "Precipitation Deviations (Challenger)"
la var lagdev2 "Precipitation Deviations (Target)"
la var lograinyravg1 "Average Precipitation (Challenger)"
la var lograinyravg2 "Average Precipitation (Target)"
la var loglaggdpcap1 "GDP/Capita (Challenger)"
la var loglaggdpcap2 "GDP/Capita (Target)"
la var loglagtpop1 "Population (Challenger)"
la var loglagtpop2 "Population (Target)"
la var lagcincrat "Capabilities Ratio"
la var lagdemdy "Joint Democracy"
la var icowsal "ICOW Salience Index"
la var lagtreat "River Treaties"
la var recmid5 "Recent Militarized Disputes"
la var recno5 "Recent Failed Settlement Attempts"
la var rivtype "Upstream/Downstream Relationship"
la var drctchal "Drought Duration (Challenger)"
la var drcttgt "Drought Duration (Target)"
la var drctchal2 "Drought Duration Squared (Challenger)"
la var drcttgt2 "Drought Duration Squared (Target)"
la var drctchal3 "Drought Duration Cubed (Challenger)"
la var drcttgt3 "Drought Duration Cubed(Target)"
sutex2 midissyr lagdev1 lagdev2 lograinyravg1 lograinyravg2 drctchal drcttgt loglagtpop1 loglagtpop2 loglaggdpcap1 loglaggdpcap2 icowsal lagtreat recmid5 recno5 lagcincrat lagdemdy, minmax varlab tabular saving("./tab/descstats.tex") replace
