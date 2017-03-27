# Iva insects latitudinal data
## m-files

* **betaNES\_pairwise.m**: a function for pairwise beta diversity (sor, sim, nes)
* **betaNES\_gradient**: apply **betaNES\_pairwise.m** over a gradient
* **mean\_rank\_shift**: calculate mean rank shift, over a gradient
* **metacommunity.m**: group data into "metacommunity" data, sum or mean. 
* **Spp2Guild.m**: function, grouping "species" into taxa or guilds
* **rarefaction.m** function, return expected richness of reduced sample size 
files
* **script\_compile\_plant3.m**: transform and compile plant data script used in **work\_compile3.m**
* **script\_fitpoly_1or2.m**: script used in **work\_abundance\_pattern.m**
* **script\_fitpoly\_latitude\_trends.m**: used in **work\_explore\_latitude\_trends.m**
* **work\_abundance\_pattern.m**: print patterns for each guild by latitude, with step-wise regression lines 
* **work\_compile\_R\_varpart3.m**: compile/transform data for doing partitioning of variation in **R**
* **work\_compile3.m**: load and tabulate original data from .csv 
* **work\_explore\_common.m**: find out common and abundant kinds
* **work\_explore\_diversity.m**: plotting richness and diversity pattern
* **work\_explore\_guild\_latitude\_PCA**: do PCA for guild composition 
* **work\_explore\_latitude\_trends.m**: latitudinal trends of richness, shannon, MRS, nestedness, turnover
* **work\_explore\_plant.m**: transform plant data and visualize in qqplot
* **work\_make\_map.m**: make map
* **work\_Mantel\_null.m**: test guild Mantel correlation
* **work\_nestedness\_Mantel.m**: nestedness vs. turnover results
* **work\_nestedness\_Mantel\_inference**: nestedness vs. turnover results
* **work\_Mantel.m**: do Mantel test (make inferences on NMDS plots). 
* **work\_NMDS\_guild\_withAxis.m**: make NMDS figures for guild composition, with axis, gray scale
* **work\_NMDS\_taxon\_withAxis.m**: make NMDS figures for guild composition, with axis, gray scale
* **work_RAC.m**: rank-abundance-curve
* **work\_setup.m**: set machine specific working directory
