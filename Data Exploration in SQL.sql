Select *
From CovidDeaths
Order by 3,4

Select *
From CovidVaccinations
Order by 3,4

Select Location,date,total_cases,new_cases,total_deaths,population
From CovidDeaths
Order by 1,2

-- Total Cases vs Total Deaths
Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
where location like '%states%'
Order by 1,2

-- Total Cases vs Population
--shows population that got covid
Select Location,date,population,total_cases,(total_cases/population)*100 as CasePercentage
From CovidDeaths
--where location like '%states%'
Order by 1,2

-- Countries with Highest Infection Rate compared to Population
Select Location,population,Max(total_cases ) AS highestInfectionCount,Max((total_cases/population))*100 as PercentagePopulationInfected
From CovidDeaths
Group by Location, Population
Order by PercentagePopulationInfected desc

-- countries with Highest Death Count per Population

Select Location,Max(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
where continent is not null
Group by Location
Order by TotalDeathCount desc

-- data per continent

Select continent,Max(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
where continent is not null
Group by continent
Order by TotalDeathCount desc

Select Location,Max(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
where continent is null
Group by Location
Order by TotalDeathCount desc

--Global Numbers
Select date,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null
Group By date
order by 1,2



--Global Numbers
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null
order by 1,2

Select*
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date

-- Total Population vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
Sum(Convert(int,vac.new_vaccinations)) over(Partition by dea.Location Order by dea.location,dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

with PopvsVac (continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
Sum(Convert(int,vac.new_vaccinations)) over(Partition by dea.Location Order by dea.location,dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
)
Select *,(RollingPeopleVaccinated/Population)*100
From PopvsVac

-- using temp table
Drop Table If exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
Sum(Convert(int,vac.new_vaccinations)) over(Partition by dea.Location Order by dea.location,dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
--where dea.continent is not null

Select *,(RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

--Creating view for later visulaizations

Create View PercentPopulationVaccinated as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
Sum(Convert(int,vac.new_vaccinations)) over(Partition by dea.Location Order by dea.location,dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null

Select*
From PercentPopulationVaccinated
