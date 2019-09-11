package ${VideModelPackageName}

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import google.architecture.common.base.viewmodle.BaseViewModel
import google.architecture.common.utils.SingletonHolderSingleArg
import ${DataSourcePackageName}.${pageName}DataSourceRepository


<#import "root://activities/MVVMTemplate/globals.xml.ftl" as gb>

<@gb.fileHeader />

class ${pageName}ViewModel(private val repo : ${pageName}DataSourceRepository) :BaseViewModel(){

	class ${pageName}ViewModuleFactory(private val repo: ${pageName}DataSourceRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T =
                ${pageName}ViewModel(repo) as T

        companion object : SingletonHolderSingleArg<${pageName}ViewModuleFactory, ${pageName}DataSourceRepository>(::${pageName}ViewModuleFactory)

    }

}