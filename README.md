# Data Professional Survey Dashboard

An interactive Power BI dashboard built from a survey of data professionals. The project explores respondents' roles, compensation, favorite programming languages, job satisfaction, and experience entering the data field.

## Project files

| File | Description |
| --- | --- |
| `Data Professional Survey Dashboard.pbix` | Power BI report with the finished dashboard. |
| `Power BI - Final Project.xlsx` | Excel source data used by the report. |

The workbook contains one sheet, **Data Professional Survey**, with 630 rows (including the header) and 28 columns. The source contains survey responses collected in 2022.

## Dashboard overview

The report has one page and includes:

- Average salary by job title
- Favorite programming language
- Survey respondents by country
- Happiness ratings for salary and work-life balance
- Respondents' reported difficulty breaking into data
- Summary cards for key survey totals and averages

The report uses a customized Power BI theme to give the visuals a consistent color palette.

## Data and preparation

The dataset includes role, career-change, salary, industry, programming-language, job-satisfaction, demographics, education, and location responses. The report follows a beginner Power BI workflow: import the Excel workbook, make a focused selection of fields and basic transformations in Power Query, then build visuals in Power BI.

The source data is not fully standardized. For example, salary responses may be entered as ranges, so salary results should be interpreted as the report's treatment of those original responses rather than as a fully cleaned compensation dataset. This project is an introductory dashboard and does not attempt comprehensive data cleaning or statistical analysis.

## Open the report

1. Download or clone this repository.
2. Open `Data Professional Survey Dashboard.pbix` in Power BI Desktop.
3. If Power BI asks for the source location, point it to `Power BI - Final Project.xlsx` in the same folder and refresh the data.

## Tools

- Microsoft Power BI Desktop
- Microsoft Excel workbook as the data source
- Power Query for data preparation

## Acknowledgment

This project was created by following a Power BI tutorial based on a survey of data professionals. The dashboard is an individual learning project developed from that tutorial and its accompanying dataset.
