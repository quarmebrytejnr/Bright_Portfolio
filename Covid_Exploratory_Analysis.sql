
select * from CovidDeaths$
--..CovidVaccinations$
where continent is not null
order by 3,4
--


Select location, Date, total_cases, new_cases, total_deaths, population 
from CovidDeaths$
where continent is not null
order by 1,2

--Total Cases Vs Total Death

Select location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage  
from CovidDeaths$ 
where continent is not null
order by 1,2

--------Percentage Of Population Infected
Select location, Date, Population, total_cases, total_deaths, (total_deaths/population)*100 as DeathPercentage  
from CovidDeaths$ 
where continent is not null
--and location = 'Ghana'
order by 1,2

--------Highest Rate of Infection Per Population

Select location, Population, max(total_cases) Highest_Infection_Rate, Max(total_deaths/population)*100 as Highest_DeathPercentage  
from CovidDeaths$ 
where continent is not null
group by location, population
order by 4  desc

-----------Highest Death Rate By Country
Select location, max(cast(total_deaths as int)) Highest_Death_Rate  
from CovidDeaths$
where continent is not null
group by location
order by location  desc

-----------Highest Death Rate By Continent
Select continent, max(cast(total_deaths as int)) Highest_Death_Rate  
from CovidDeaths$
where continent is not null
group by continent
order by 2 desc


-----------Highest Death Rate By Continent
--Select location, max(cast(total_deaths as int)) Highest_Death_Rate  
--from CovidDeaths$
--where continent is null
--group by location
--order by 2 desc

-----------------Daily Global Outlook------------

Select Date, sum(new_cases) Total_New_Cases, sum(cast(new_deaths as int)) Total_New_Deaths, 
Sum(cast(new_deaths as int))/sum(new_cases)*100  DeathPercentage  
from CovidDeaths$ 
where continent is not null
group by Date
order by 1,2 

-----------------Daily Global Outlook------------

Select sum(new_cases) Total_New_Cases, sum(cast(new_deaths as int)) Total_New_Deaths, 
Sum(cast(new_deaths as int))/sum(new_cases)*100  DeathPercentage  
from CovidDeaths$ 
where continent is not null
--group by Date
order by 1,2 


--------------------Vacination Imapct--------------

select * 
from CovidDeaths$ d
join CovidVaccinations$ v 
on d.location =v.location and d.date = v.date


------------Population Vaccincated-----------------

select d.continent, d.location, d.date, d.population, v.new_vaccinations 
from CovidDeaths$ d
join CovidVaccinations$ v 
on d.location =v.location and d.date = v.date
where d.continent is not null
order by 5 desc

-------------Vaccination Global Overview---------------

select d.continent, d.location, d.date, d.population,v.new_vaccinations, 
sum(CONVERT(int,v.new_vaccinations)) Over(Partition by d.location order by d.location, d.date) Total_Vaccination
from CovidDeaths$ d
join CovidVaccinations$ v 
on d.location =v.location and d.date = v.date
where d.continent is not null
order by 5 desc


-----------------------Population Vaccinated-----------
With PopVac (Continent, Location, Date, Population, New_vaccinations, Total_Vaccination)
as
(
select d.continent, d.location, d.date, d.population,v.new_vaccinations, 
sum(CONVERT(int,v.new_vaccinations)) Over(Partition by d.location order by d.location, d.date) Total_Vaccination
from CovidDeaths$ d
join CovidVaccinations$ v 
on d.location =v.location and d.date = v.date
where d.continent is not null
)

Select *, (Total_Vaccination/Population)* 100 Percentage_Vacciniated  from PopVac 
where location = 'Ghana'

-----------TMP--------------
Drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Total_Vaccination numeric
)

insert into #PercentPopulationVaccinated
select d.continent, d.location, d.date, d.population,v.new_vaccinations, 
sum(CONVERT(int,v.new_vaccinations)) Over(Partition by d.location order by d.location, d.date) Total_Vaccination
from CovidDeaths$ d
join CovidVaccinations$ v 
on d.location =v.location and d.date = v.date
where d.continent is not null

Select *, (Total_Vaccination/Population)* 100 Percentage_Vacciniated  
from #PercentPopulationVaccinated 
where location = 'Ghana'

---------------Create View -----------
Create View PercentPopulationVaccinated as
select d.continent, d.location, d.date, d.population,v.new_vaccinations, 
sum(CONVERT(int,v.new_vaccinations)) Over(Partition by d.location order by d.location, d.date) Total_Vaccination
from CovidDeaths$ d
join CovidVaccinations$ v 
on d.location =v.location and d.date = v.date
where d.continent is not null