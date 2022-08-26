Select 
* 
FROM [Portfolio_Project].[dbo].[NashVile_Housing$];

------------Change Date Format------------------
Select SaleDate, CONVERT(Date,SaleDate) DATE_
FROM [Portfolio_Project].[dbo].[NashVile_Housing$];

ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
ADD Sales_Date Date;

UPDATE [Portfolio_Project].[dbo].[NashVile_Housing$]
SET Sales_Date = CONVERT(Date, SaleDate);

------Property Address Nulls------------
Select 
a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio_Project].[dbo].[NashVile_Housing$] a
Join [Portfolio_Project].[dbo].[NashVile_Housing$] b on a.ParcelID = b.ParcelID and a.[UniqueID] <> b.[UniqueID]
;
 
Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Portfolio_Project].[dbo].[NashVile_Housing$] a
Join [Portfolio_Project].[dbo].[NashVile_Housing$] b 
on a.ParcelID = b.ParcelID and a.[UniqueID] <> b.[UniqueID]


-------------Seperating the Address into City, State etc--------------
Select PropertyAddress
FROM [Portfolio_Project].[dbo].[NashVile_Housing$] 
;


Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) P_City
FROM [Portfolio_Project].[dbo].[NashVile_Housing$] 
;


ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
ADD Address_ Nvarchar(255);

UPDATE [Portfolio_Project].[dbo].[NashVile_Housing$]
SET Address_ = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1);


ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
ADD City_ Nvarchar(255);

UPDATE [Portfolio_Project].[dbo].[NashVile_Housing$]
SET City_ = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress));


----------Seperating Owner Adress using Parse-------------
Select PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from [Portfolio_Project].[dbo].[NashVile_Housing$];

ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
Add OwnerSplitAddress Nvarchar(255);

Update [Portfolio_Project].[dbo].[NashVile_Housing$]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
Add OwnerSplitCity Nvarchar(255);

Update [Portfolio_Project].[dbo].[NashVile_Housing$]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
Add OwnerSplitState Nvarchar(255);

Update [Portfolio_Project].[dbo].[NashVile_Housing$]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


-----CHANGE Y/N to Yes/No
select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [Portfolio_Project].[dbo].[NashVile_Housing$]
Group by SoldAsVacant
order by 2

Select 
SoldAsVacant
,Case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end Vacant
From [Portfolio_Project].[dbo].[NashVile_Housing$]


UPDATE [Portfolio_Project].[dbo].[NashVile_Housing$]
SET SoldAsVacant = Case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end 


----------------Remove Duplicates-------------

WITH RowNumCTE AS(
SELECT *, 
ROW_NUMBER() 
OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice,SaleDate,LegalReference
ORDER BY UniqueID) row_num_part 
from 
[Portfolio_Project].[dbo].[NashVile_Housing$]
)

 
--DELETE 
--from RowNumCTE
--Where row_num_part > 1

select * 
from RowNumCTE
Where row_num_part > 1


--------------DELETE COLUMNS---------------
ALTER TABLE [Portfolio_Project].[dbo].[NashVile_Housing$]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

Select 
* 
FROM [Portfolio_Project].[dbo].[NashVile_Housing$];