User Guide
================

* [Overview](#overview)
  * [How to Cite](#cite)
* [Data Settings](#data-settings)
  * [Data Type](#type)
  * [Dataset](#dataset)
  * [Import Data](#import)
* [General Settings](#gen-settings)
  * [Estimator](#estimator)
  * [Bootstraps](#bootstraps)
  * [Confidence level](#confidence)
* [Output](#output)
  * [Data Summary](#summary)
  * [Esitmation](#chaoentropy)
* [References](#reference)

* * * * * * * *

<h2 id="overview">Overview</h2>


The program **ChaoEntropy** (Shannon **entropy** proposed by **Chao** et al.) online is written in the [R][] language and the interactive web application is built by using [Shiny][]. The user provides a vector of abundances of individual species (abundance data) or incidences of individual species (incidence data). **ChaoEntropy** computes the Shannon entropy estimators and associated confidence intervals.

<h3 id="cite">How to Cite</h3>
<font color="ff0000">If you use **ChaoEntropy** to obtain results for publication, you should cite at least one of the relevant papers (Chao, A., Wang, Y. T. and Jost, L. (2013) Entropy and the species accumulation curve: a novel entropy estimator via discovery rates of new species. To appear in Methods in Ecology and Evolution.)</font>

To help refine **ChaoEntropy**, your comments or feedbacks would be welcome (please send them to chao@stat.nthu.edu.tw).
 [R]: http://www.r-project.org/
[Shiny]: http://www.rstudio.com/shiny/

<h2 id="data-settings">Data Settings</h2>
<h3 id="type">Data Type</h3>
**ChaoEntropy** supports two types of data for computation the Shannon entropy:
* Abundance data: a vector of abundances of individual species in the sample.
* Incidence data: a vector of incidences of individual species in the sample (i.e., the number of sampling units that a species is found). 
User should select one of the data types to obtain output. Not only the data format but also the statistical method for the two data types are different. Please make sure you select the correct data type.

<h3 id="dataset">Dataset</h3>
Some demonstration datasets are used for illustration. 
* Abundance data: tropical foliage insects data in two sites: Oldgrowth and Secondgrowth (Janzen 1973a, b)
* Incidence data: tropical rain forest ants data by three collecting methods: Berlese, Malaise and fogging (Longino et al. 2002)
We suggest that you first run these demo datasets and try to understand the output before you import your own data sets. 
All the titles of the demo data and imported data (see [Import Data](#import) for details) are listed in this list box. You can choose a single dataset or multiple datasets for comparisons. 

<h3 id="import">Import Data</h3>
**ChaoEntropy** provides a visualized import data function. After checking the checkbox: **Import data**, user can input data (line by line) in the text area; the title of your imported data will be listed in the box: **Select dataset**. The import formats for the abundance data and incidence data are different. The data formats for the two types of data are described below.
* Import abundance data: 
We use a simple example to show how to import abundance data. Consider the spider data and the birds data (spider data is provided by Sackett et al. (2011); birds data is provided by Magurran, A. E. (1988))

  ```{r}
  Spider 46 22 17 15 15  9  8  6  6  4  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  
  Birds 752 276 194 126 121 97  95  83  72  44  39  0  16  15  0  13  9  9  9  8  7  4  0  0  2  2  1  1  1
  ```

Since there are two datasets, the imported data contain two lines (separated by return). The first line includes the species abundances for 26 species in the Spider and the second line includes the species abundances for 25 species in the Birds. **For each line, the first entry is the title of the dataset (the title is not allowed to start with a numerical digit) followed by the species abundances.** All entries should be separated by blank space (" "). For example, in the Spider, the most abundant species is represented by 46 individuals, the second most abundant species is represented by 22 individuals in the sample, etc. Although the species abundances in this example are entered in a decreasing order, the ordering is not relevant in our analysis. You can choose any ordering of species abundances. 

* Import incidence data:
  We use the ant data and the seedlings data (ant data is provided by Longino et al. (2002); seedlings data is provided by Colwell and Coddington (1994)) as an example:
  
  ```{r}
  Ant 62  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  3  3  3  3  3  3  3  3  3  3  3  3  3  4  4  4  4  4  4  4  5  5  5  5  6  6  7  9  9  9  9 10 10 12 13 14 14 14 15 15 16 18 19 19 20 29
  Seedlings 121  61  47  52  43  43   9  24   5  24  11  11  13  17   6  10   3   8   9   9  3   6   6   1   7   4   6   6   4   3   4   2   2   1   1
  ```

The import data contain two lines (separated by return), the first line includes ant data , and the second line includes seedlings data. ** For each line, the first entry is the title of the dataset (the title is not allowed to start with a numerical digit), the second entry is the total number of sampling units, followed by the species incidences abundances (the number of sampling units that each species is found). ** All element entries should be separated by blank space (" "). For example, ant data, 62 sampling units were used. The most frequent species was found in 29 sampling units, the second most frequent species was found in 20 units, etc. Although the species incidences in this example are entered in a decreasing order, the ordering is not relevant in our analysis.

<h2 id="gen-settings">General settings</h2>
<h3 id="estimator">Estimator</h3>
The estimator is a checkbox for select the method which constructed to estimate Shannon entropy.
  * __Chao__ estimator, see Chao et al. (2013)
  * __ChaoShen__ estimator, see Chao and Shen (2003)
  * __Grassberger__ estimator, see Grassberger (2003)
  * __Jackknife__ estimator, see Zhal (1977)
  * __Zhang__ estimator, see Zhang (2012)
  * __Observed__ estimator, the observed entropy estimator

<h3 id="bootstraps">Bootstraps</h3>
Number of bootstraps (say B) is an integer specifying the number of replications for bootstrap resampling scheme in computing variance. Refer to Chao et al. (2013) for details. Default is 100. To save running time, we recommend that 100 or 200 bootstraps will be sufficient for most applications.  

<h3 id="confidence">Confidence level</h3>
The confidence level is a positive number $\le 1$ for confidence interval. The default is 0.95.

<h2 id="output">Output</h2>
<h3 id="summary">Data Summary</h3>
This tab panel shows basic data information for the selected data. The output variables are interpreted at the bottom of the tab panel. Click [Download as csv file]() to download the output summary.

<h3 id="chaoentropy">Rarefaction/Extrapolation</h3>
This tab panel shows the main output for **ChaoEntropy**. The output variables are interpreted at the bottom of the tab panel. Click [Download as csv file]() to download the output table.

<h3 id="plot"> Figure Plots</h3>
This tab panel shows three species rarefaction/extrapolation curves (described in [Overview](#overview)). Click [Download as PDF]() to download any figure.
  
<h2 id="reference">References</h2>

1. Chao, A., N. J. Gotelli, T. C. Hsieh, E. L. Sander, K. H. Ma, R. K. Colwell, and A. M. Ellison 2013. Rarefaction and extrapolation with Hill numbers: a unified framework for sampling and estimation in biodiversity studies, Ecological Monographs (to appear).

2. Chao, A., and L. Jost. 2012. Coverage-based rarefaction and extrapolation: standardizing samples by completeness rather than size. Ecology 93:2533-2547.

3. Colwell, R. K., A. Chao, N. J. Gotelli, S. Y. Lin, C. X. Mao, R. L. Chazdon, and J. T. Longino. 2012. Models and estimators linking individual-based and sample-based rarefaction, extrapolation and comparison of assemblages. Journal of Plant Ecology 5:3-21.

4. Ellison, A. M., A. A. Barker-Plotkin, D. R. Foster, and D. A. Orwig. 2010. Experimentally testing the role of foundation species in forests: the Harvard Forest Hemlock Removal Experiment. Methods in Ecology and Evolution 1:168-179.

5. Hsieh, T. C., K. H. Ma, and A. Chao. 2013. **ChaoEntropy** online: interpolation and extrapolation (Version 1.0) [Software]. Available from http://chao.stat.nthu.edu.tw/blog/software-download/.

6. Longino, J. T., and R. K. Colwell. 2011. Density compensation, species composition, and richness of ants on a neotropical elevational gradient. Ecosphere 2:art29.

7. Sackett, T. E., S. Record, S. Bewick, B. Baiser, N. J. Sanders, and A. M. Ellison. 2011. Response of macroarthropod assemblages to the loss of hemlock (Tsuga canadensis), a foundation species. Ecosphere 2: art74.
