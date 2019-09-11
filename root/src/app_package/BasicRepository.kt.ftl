package ${DataSourcePackageName}

<#if needLocalDataSource && needRemoteDataSource>
import google.architecture.common.base.repository.BaseRepositoryBoth
<#elseif needRemoteDataSource>
import google.architecture.common.base.repository.BaseRepositoryRemote
<#elseif needLocalDataSource>
import google.architecture.common.base.repository.BaseRepositoryLocal
</#if>

import google.architecture.common.base.repository.ILocalDataSource
import google.architecture.common.base.repository.IRemoteDataSource

<#import "root://activities/MVVMTemplate/globals.xml.ftl" as gb>

<@gb.fileHeader />

class ${dataSourceRepositoryName}(<#if needRemoteDataSource && needLocalDataSource>remoteDataSource: ${remoteDataSourceName},localDataSource: ${localDataSourceName}
	<#elseif needRemoteDataSource>remoteDataSource: ${remoteDataSourceName}<#elseif needLocalDataSource>localDataSource: ${localDataSourceName}</#if>):
	<#if needRemoteDataSource && needLocalDataSource>BaseRepositoryBoth<#elseif needRemoteDataSource>BaseRepositoryRemote<#elseif needLocalDataSource>BaseRepositoryLocal</#if><<#if needRemoteDataSource && needLocalDataSource>${remoteDataSourceName},${localDataSourceName}<#elseif needRemoteDataSource>${remoteDataSourceName}<#elseif needLocalDataSource>${localDataSourceName}</#if>>(<#if needRemoteDataSource && needLocalDataSource>remoteDataSource,localDataSource<#elseif needRemoteDataSource>remoteDataSource<#elseif needLocalDataSource>localDataSource</#if>)
	
<#if needRemoteDataSource>class ${remoteDataSourceName} : IRemoteDataSource</#if>

<#if needLocalDataSource>class ${localDataSourceName} : ILocalDataSource</#if>
