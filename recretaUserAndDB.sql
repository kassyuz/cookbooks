set @sqlUserFluig="litelims_dev";
set @sqlPassFluig="!litelims@2016";
set @sqlDB="litelims_dev";

SET @sql = CONCAT('DROP DATABASE IF EXISTS ', @sqlDB);
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SET @sql = CONCAT('GRANT USAGE ON *.* TO ''', @sqlUserFluig, '''@''%'' IDENTIFIED BY ''password''');
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SET @sql = CONCAT('DROP USER ''', @sqlUserFluig, '''@''%''');
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SET @sql = CONCAT('CREATE USER ''', @sqlUserFluig, '''@''%'' IDENTIFIED BY ''', @sqlPassFluig, '''');
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SET @sql = CONCAT('CREATE DATABASE ', @sqlDB, ' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci');
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SET @sql = CONCAT('GRANT ALL PRIVILEGES ON ', @sqlDB, '.* TO ''', @sqlUserFluig, '''@''%'' IDENTIFIED BY ''', @sqlPassFluig, '''');
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
