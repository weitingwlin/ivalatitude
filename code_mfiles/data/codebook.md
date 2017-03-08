# Code book for Iva latitudinal data
## Overview
 This data set is the e... The ... was done May/17~June/26, 2014 on ....
 In the ...

## txtdata

### data files in .txt format

* **bugdata.txt**: 
  + bug individual counts from the beat sample. 
  + 339 rows; each is a beat sample. (with one exception see ??)
  + 178 columns; each is a "kind" of insect, classified as much as possible.
* **sampledata.txt**:
  + information of the beat samples.
  + 339 rows; each is a beat sample correspond to rows in **bugdata.txt**
  + 3 columns; information (sitecode, month, replicates) of each beat sample.
* **siteinfo.txt**:
  + information of the sampling sites 
  + 15 rows; each is one sampling sites, see??
  + 3 columns; information (sitecode, decimallatitude, region) of each site.
* **guildcode.txt**
  + guild assigned to each "kind" of insect
  + 178 data(row); match the 178 columns in **bugdata.txt**; see variable for detail
* **taxon.txt**
  + taxon assigned to each "kind" of insect.
  + 178 data(row); match the 178 columns in **bugdata.txt**; see variable for detail


## csvdata

### data files in .csv format

* **arthropoddata.csv**
* **guild\_and\_taxon.csv**
* **plantdata.csv**
* **sampledata.csv**
* **sitedata.csv**
