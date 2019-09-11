package ${ModulePackageName}


import org.kodein.di.Kodein
import org.kodein.di.android.x.AndroidLifecycleScope
import org.kodein.di.generic.*
import androidx.lifecycle.ViewModelProviders

import ${VideModelPackageName}.${pageName}ViewModel
import ${DataSourcePackageName}.${pageName}DataSourceRepository



<#if needActivity && needFragment>
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
<#elseif needActivity>
import androidx.appcompat.app.AppCompatActivity
<#elseif needFragment>
import androidx.fragment.app.Fragment
</#if>

<#import "root://activities/MVVMTemplate/globals.xml.ftl" as gb>

<@gb.fileHeader />

const val ${extractLetters(pageName?upper_case)}_MODULE_TAG = "${extractLetters(pageName?upper_case)}_MODULE_TAG"

val ${classToResource(pageName)}KodeinModule = Kodein.Module(${extractLetters(pageName?upper_case)}_MODULE_TAG) {

    <#if needActivity && needFragment>
	bind<${pageName}ViewModel>() with scoped<AppCompatActivity>(AndroidLifecycleScope).singleton{
		ViewModelProviders
		    .of(context!!,${pageName}ViewModel.${pageName}ViewModuleFactory.getInstance(instance()))
		    .get(${pageName}ViewModel::class.java)
	}
    bind<${pageName}ViewModel>() with scoped<Fragment>(AndroidLifecycleScope).singleton {
        ViewModelProviders
            .of(context.activity!!,${pageName}ViewModel.${pageName}ViewModuleFactory.getInstance(instance()))
            .get(${pageName}ViewModel::class.java)
    }
    <#elseif needActivity>
    bind<${pageName}ViewModel>() with scoped<AppCompatActivity>(AndroidLifecycleScope).singleton{
        ViewModelProviders
            .of(context!!,${pageName}ViewModel.${pageName}ViewModuleFactory.getInstance(instance()))
            .get(${pageName}ViewModel::class.java)
    }
    <#elseif needFragment>
    bind<${pageName}ViewModel>() with scoped<Fragment>(AndroidLifecycleScope).singleton {
        ViewModelProviders
            .of(context.activity!!,${pageName}ViewModel.${pageName}ViewModuleFactory.getInstance(instance()))
            .get(${pageName}ViewModel::class.java)
    }
    </#if>

    <#if needDataSourceRepository>
	bind<${dataSourceRepositoryName}>() with scoped<AppCompatActivity>(AndroidLifecycleScope).singleton {
        <#if needRemoteDataSource && needLocalDataSource>${dataSourceRepositoryName}(instance(), instance())
        <#elseif needRemoteDataSource || needLocalDataSource>${dataSourceRepositoryName}(instance())</#if>
    }

    <#if needRemoteDataSource>
    bind<${remoteDataSourceName}>() with scoped<AppCompatActivity>(AndroidLifecycleScope).singleton {
        ${remoteDataSourceName}()
    }
    </#if>

    <#if needLocalDataSource>
    bind<${localDataSourceName}>() with scoped<AppCompatActivity>(AndroidLifecycleScope).singleton {
        ${localDataSourceName}()
    }
    </#if>

    </#if>

}